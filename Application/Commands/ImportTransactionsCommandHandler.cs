using CsvHelper;
using MediatR;
using PFM.Application.DTOs;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Application.Commands;

public class ImportTransactionsCommandHandler : IRequestHandler<ImportTransactionsCommand>
{
    private readonly ITransactionRepository _repository;

    public ImportTransactionsCommandHandler(ITransactionRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(ImportTransactionsCommand request,
        CancellationToken cancellationToken)
    {
        // Kopiraj stream u memoriju ASYNC
        using var memoryStream = new MemoryStream();
        await request.CsvStream.CopyToAsync(memoryStream, cancellationToken);
        memoryStream.Position = 0;

        // Sada čitaj iz memorije
        using var reader = new StreamReader(memoryStream);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        var records = csv.GetRecords<TransactionCsvDto>();

        var transactions = records.Select(csvRecord => new Transaction
        {
            Id = csvRecord.Id,
            BeneficiaryName = csvRecord.BeneficiaryName,
            Date = csvRecord.Date,
            Direction = Enum.Parse<Direction>(csvRecord.Direction, ignoreCase: true),
            Amount = (decimal)csvRecord.Amount,
            Description = csvRecord.Description,
            Currency = csvRecord.Currency,
            Mcc = csvRecord.Mcc,
            Kind = Enum.Parse<TransactionKind>(csvRecord.Kind, ignoreCase: true)
        }).ToList();

        // Dodaj sve odjednom
        await _repository.AddRangeAsync(transactions);
        await _repository.SaveChangesAsync();
    }

    
}

