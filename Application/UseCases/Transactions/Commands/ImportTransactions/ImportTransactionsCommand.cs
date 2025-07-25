using MediatR;

namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionsCommand : IRequest
{
    public required Stream CsvStream { get; set; }
}

