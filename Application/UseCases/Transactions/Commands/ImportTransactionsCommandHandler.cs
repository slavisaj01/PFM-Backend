using CsvHelper;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.DTOs;
using PFM.Application.Exceptions;
using PFM.Application.Validators;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;
using System.Globalization;


namespace PFM.Application.UseCases.Transactions.Commands;

public class ImportTransactionsCommandHandler : IRequestHandler<ImportTransactionsCommand>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;

    public ImportTransactionsCommandHandler(ITransactionRepository repository, IUnitOfWork unitOfWork)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(ImportTransactionsCommand request,
        CancellationToken cancellationToken)
    {
        using var memoryStream = new MemoryStream();
        await request.CsvStream.CopyToAsync(memoryStream, cancellationToken);
        memoryStream.Position = 0;

        using var reader = new StreamReader(memoryStream);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);
        var records = csv.GetRecords<TransactionCsvDto>();

        var validator = new TransactionCsvDtoValidator();
        var invalidRecords = new List<string>();

        foreach (var record in records)
        {
            var result = validator.Validate(record);
            if (!result.IsValid)
            {
                var message = $"Invalid record ID {record.Id}: " +
                              string.Join(" | ", result.Errors.Select(e => e.ErrorMessage));
                invalidRecords.Add(message);
            }
        }

        if (invalidRecords.Count != 0)
        {
            throw new BusinessException(
            problem: "validation-error",
            message: "CSV contains invalid rows",
            details: string.Join("; ", invalidRecords)
            );
        }

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

        await _repository.AddRangeAsync(transactions);
        await _unitOfWork.SaveChangesAsync();
    }


}

