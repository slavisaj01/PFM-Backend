using MediatR;
using PFM.Application.Common;
using PFM.Application.Common.Constants;
using PFM.Application.Common.Exceptions;
using PFM.Application.Common.Interfaces;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Text.RegularExpressions;

namespace PFM.Application.UseCases.Transactions.Commands.SplitTransaction;

public class SplitTransactionCommandHandler : IRequestHandler<SplitTransactionCommand,Unit>
{
    private readonly ITransactionRepository _transactionRepository;
    private readonly ICategoryRepository _categoryRepository;
    private readonly ITransactionSplitRepository _transactionSplitRepository;
    private readonly IUnitOfWork _unitOfWork;

    public SplitTransactionCommandHandler(ITransactionRepository transactionRepository,
        ICategoryRepository categoryRepository,
        ITransactionSplitRepository transactionSplitRepository,
        IUnitOfWork unitOfWork)
    {
        _transactionRepository = transactionRepository;
        _categoryRepository = categoryRepository;
        _transactionSplitRepository = transactionSplitRepository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Unit> Handle(SplitTransactionCommand request, CancellationToken cancellationToken)
    {
        if (request.Splits == null || request.Splits.Count <= 1)
        {
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.InvalidSplitCount,
                "At least two splits are required to split a transaction."
            );
        }

        var transaction = await _transactionRepository.GetByIdAsync(request.Id);
        if (transaction is null)
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.ProvidedTransactionDoesNotExist,
                $"Transaction with ID '{request.Id}' not found."
                );

        var splitCatcodes = request.Splits
            .Select(s => s.Catcode)
            .Where(c => !string.IsNullOrWhiteSpace(c)) 
            .Cast<string>()
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .ToList();
        var existingCatcodes = await _categoryRepository.GetExistingCatcodesAsync(splitCatcodes);

        var missingCatcodes = splitCatcodes.Except(existingCatcodes, StringComparer.OrdinalIgnoreCase).ToList();
        if(missingCatcodes.Count != 0)
        {
            var missing = string.Join(", ", missingCatcodes);
            throw BusinessProblemMessages.Create(BusinessProblemCodes.ProvidedCategoryDoesNotExist,
                $"Invalid catcode(s): {missing}");
        }

        var totalSplitAmount = request.Splits.Sum(s => (decimal)s.Amount);
        if (totalSplitAmount != transaction.Amount)
        {
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.SplitAmountOverTransactionAmount,
                "Total split amount does not match the transaction amount."
            );
        }

        await _transactionSplitRepository.DeleteByTransactionIdAsync(request.Id);

        var newSplits = request.Splits.Select(s => new TransactionSplit
        {
            TransactionId = request.Id,
            CategoryCode = s.Catcode!,
            Amount = (decimal)s.Amount
        }).ToList();

        await _transactionSplitRepository.AddRangeAsync(newSplits);

        await _unitOfWork.SaveChangesAsync();

        return Unit.Value;
    }
}
