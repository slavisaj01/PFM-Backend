using MediatR;
using PFM.Application.DTOs;

namespace PFM.Application.UseCases.Transactions.Commands.SplitTransaction;

public class SplitTransactionCommand : IRequest<Unit>
{
    public string Id { get; set; } = default!;
    public List<TransactionSplitDto> Splits { get; set; } = [];
}
