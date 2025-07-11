using MediatR;

namespace PFM.Application.UseCases.Transactions.Commands;

public class ImportTransactionsCommand : IRequest
{
    public Stream CsvStream { get; set; }
}

