using AutoMapper;
using CsvHelper;
using MediatR;
using Microsoft.Extensions.Logging;
using PFM.Application.Common;
using PFM.Application.Common.Constants;
using PFM.Application.Common.Exceptions;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Text;

namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionsCommandHandler : IRequestHandler<ImportTransactionsCommand>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;

    public ImportTransactionsCommandHandler(ITransactionRepository repository, IUnitOfWork unitOfWork,
        ICsvParser csvParser, IMapper mapper)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
        _csvParser = csvParser;
        _mapper = mapper;
    }

    public async Task Handle(ImportTransactionsCommand request, CancellationToken cancellationToken)
    {
        List<TransactionCsvDto> csvRecords;
        try
        {
            csvRecords = await _csvParser.ParseAsync<TransactionCsvDto>
               (request.CsvStream, cancellationToken);
        }
        catch (CsvHelperException)
        {
            throw BusinessProblemMessages.Create(BusinessProblemCodes.CsvParsingError,
                "Ensure the CSV file has the correct delimiter, headers, and consistent structure.");
        }

        var validator = new ImportTransactionCsvDtoValidator();

        var validRecords = new List<TransactionCsvDto>();

        var invalidRecords = new List<(TransactionCsvDto Record, List<ValidationErrorDto> Errors)>();

        foreach (var record in csvRecords)
        {
            var result = validator.Validate(record);
            if (result.IsValid)
            {
                validRecords.Add(record);
            }
            else
            {
                var errors = result.Errors.Select(e => new ValidationErrorDto
                {
                    Tag = e.PropertyName,
                    Error = ValidationErrorMapper.Map(e),
                    Message = e.ErrorMessage
                }).ToList();

                invalidRecords.Add((record, errors));
            }
        }

        if (invalidRecords.Count != 0)
        {
            Directory.CreateDirectory("logs"); 

            var logBuilder = new StringBuilder();

            var timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            logBuilder.AppendLine($"=== Invalid transactions at {timestamp} ===");
            logBuilder.AppendLine();

            foreach (var (record, errors) in invalidRecords)
            {
                logBuilder.AppendLine($"(ID: {(!string.IsNullOrWhiteSpace(record.Id) ? record.Id : "<empty>")})");

                foreach (var error in errors)
                {
                    logBuilder.AppendLine($" - {error.Tag}: {error.Message}");
                }

                logBuilder.AppendLine();
            }

            logBuilder.AppendLine($"Imported: {validRecords.Count} / Skipped: {invalidRecords.Count}");
            logBuilder.AppendLine("----------------------------------------------");
            logBuilder.AppendLine();

            await File.AppendAllTextAsync("logs/invalid-transactions.txt", logBuilder.ToString());
        }

        foreach (var record in validRecords)
        {
            var existing = await _repository.GetByIdAsync(record.Id!);
            if (existing is not null)
            {
                throw BusinessProblemMessages.Create(BusinessProblemCodes.TransactionAlreadyExists,
                    $"Transaction with ID '{record.Id}' already exists. Transaction IDs must be unique."
);
            }
        }

        if (validRecords.Count != 0)
        {
            var transactions = _mapper.Map<List<Transaction>>(validRecords);
            await _repository.AddRangeAsync(transactions);
            await _unitOfWork.SaveChangesAsync();
        }
    }
}

