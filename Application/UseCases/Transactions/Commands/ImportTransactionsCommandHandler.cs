using CsvHelper;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.DTOs;
using PFM.Application.Exceptions;
using PFM.Application.Helpers;
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
        var records = csv.GetRecords<TransactionCsvDto>().ToList();

        var validator = new TransactionCsvDtoValidator();
        var validationErrors = new List<ValidationErrorDto>();

        foreach (var record in records)
        {
            var result = validator.Validate(record);
            if (!result.IsValid)
            {
                foreach (var error in result.Errors)
                {
                    validationErrors.Add(new ValidationErrorDto
                    {
                        Tag = error.PropertyName,
                        Error = ValidationErrorMapper.Map(error),
                        Message = $"Invalid record ID {record.Id}: {error.ErrorMessage}"
                    });
                }
            }
        }

        if (validationErrors.Count != 0)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = validationErrors
            });
        }

        var transactions = records.Select(csvRecord => new Transaction
        {
            Id = csvRecord.Id,
            BeneficiaryName = csvRecord.BeneficiaryName,
            Date = DateTime.Parse(csvRecord.Date),
            Direction = Enum.Parse<Direction>(csvRecord.Direction, ignoreCase: true),
            Amount = (decimal)csvRecord.Amount.Value,
            Description = csvRecord.Description,
            Currency = csvRecord.Currency,
            Mcc = csvRecord.Mcc,
            Kind = Enum.Parse<TransactionKind>(csvRecord.Kind, ignoreCase: true)
        }).ToList();

        await _repository.AddRangeAsync(transactions);

        await _unitOfWork.SaveChangesAsync();
    }


}

