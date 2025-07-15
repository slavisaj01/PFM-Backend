using MediatR;

namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionsCommand : IRequest
{
    public Stream CsvStream { get; set; }
}

