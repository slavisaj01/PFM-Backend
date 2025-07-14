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

    public async Task Handle(ImportTransactionsCommand request, CancellationToken cancellationToken)
    {
        using var reader = new StreamReader(request.CsvStream, leaveOpen: true);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        var validator = new TransactionCsvDtoValidator();
        var validationErrors = new List<ValidationErrorDto>();
        var transactions = new List<Transaction>();

        await foreach (var record in csv.GetRecordsAsync<TransactionCsvDto>(cancellationToken))
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
            else
            {
                transactions.Add(new Transaction
                {
                    Id = record.Id,
                    BeneficiaryName = record.BeneficiaryName,
                    Date = DateTime.Parse(record.Date),
                    Direction = Enum.Parse<Direction>(record.Direction, ignoreCase: true),
                    Amount = (decimal)record.Amount.Value,
                    Description = record.Description,
                    Currency = record.Currency,
                    Mcc = record.Mcc,
                    Kind = Enum.Parse<TransactionKind>(record.Kind, ignoreCase: true)
                });
            }
        }

        if (validationErrors.Count != 0)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = validationErrors
            });
        }

        await _repository.AddRangeAsync(transactions);
        await _unitOfWork.SaveChangesAsync();
    }


}

