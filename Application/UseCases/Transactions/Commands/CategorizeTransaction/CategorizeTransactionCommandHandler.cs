using PFM.Application.Common;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.Common.Constants;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;

public class CategorizeTransactionCommandHandler : IRequestHandler<CategorizeTransactionCommand>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;

    public CategorizeTransactionCommandHandler(ITransactionRepository repository,
        IUnitOfWork unitOfWork)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(CategorizeTransactionCommand request, CancellationToken cancellationToken)
    {
        var transaction = await _repository.GetByIdAsync(request.Id, cancellationToken);
        //TO-DO EXCEPTION

        var category = await _repository.GetByCodeAsync(request.Catcode, cancellationToken);
        if (category is null)
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.ProvidedCategoryDoesNotExist,
                $"Catcode '{request.Catcode}' not found.");

        transaction.CatCode = request.Catcode;

        await _unitOfWork.SaveChangesAsync();
    }
}
