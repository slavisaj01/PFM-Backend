using MediatR;

namespace PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;

public class CategorizeTransactionCommand : IRequest<Unit>
{
    public string Id { get; set; }
    public string Catcode { get; set; }
}
