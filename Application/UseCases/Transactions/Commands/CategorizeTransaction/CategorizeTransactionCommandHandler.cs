using PFM.Application.Common;
using PFM.Application.Common.Interfaces;
using MediatR;
using PFM.Application.Common.Constants;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;

public class CategorizeTransactionCommandHandler : IRequestHandler<CategorizeTransactionCommand, Unit>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;

    public CategorizeTransactionCommandHandler(ITransactionRepository repository,
        IUnitOfWork unitOfWork)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Unit> Handle(CategorizeTransactionCommand request, CancellationToken cancellationToken)
    {
        var transaction = await _repository.GetByIdAsync(request.Id, cancellationToken);
        if (transaction is null)
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.ProvidedTransactionDoesNotExist,
                $"Transaction with ID '{request.Id}' does not exist.");

        var category = await _repository.GetByCodeAsync(request.Catcode, cancellationToken);
        if (category is null)
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.ProvidedCategoryDoesNotExist,
                $"Catcode with ID '{request.Catcode}' does not exist.");

        transaction.CatCode = request.Catcode;

        await _unitOfWork.SaveChangesAsync();

        return Unit.Value;
    }
}
