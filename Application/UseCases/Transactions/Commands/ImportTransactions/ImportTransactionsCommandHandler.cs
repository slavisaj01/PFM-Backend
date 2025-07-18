using MediatR;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;
using PFM.Domain.Interfaces;
using AutoMapper;
using Microsoft.Extensions.Logging;
using PFM.Domain.Entities;

namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionsCommandHandler : IRequestHandler<ImportTransactionsCommand>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;
    private readonly ILogger<ImportTransactionsCommandHandler> _logger;

    public ImportTransactionsCommandHandler(ITransactionRepository repository, IUnitOfWork unitOfWork,
        ICsvParser csvParser, IMapper mapper,
        ILogger<ImportTransactionsCommandHandler> logger)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
        _csvParser = csvParser;
        _mapper = mapper;
        _logger = logger;
    }

    public async Task Handle(ImportTransactionsCommand request, CancellationToken cancellationToken)
    {
        var csvRecords = await _csvParser.ParseAsync<TransactionCsvDto>
            (request.CsvStream, cancellationToken);

        var validator = new ImportTransactionCsvDtoValidator();//mozda DI umesto rucno kreiranje

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

        foreach (var (record, errors) in invalidRecords)
        {
            _logger.LogWarning("Invalid record (ID: {Id}):", string.IsNullOrWhiteSpace
                (record.Id) ? "<empty>" : record.Id);
            foreach (var error in errors)
            {
                _logger.LogWarning(" - {Tag}: {Message}", error.Tag, error.Message);
            }
        }

        if (validRecords.Count != 0)
        {
            var transactions = _mapper.Map<List<Transaction>>(validRecords);
            await _repository.AddRangeAsync(transactions);
            await _unitOfWork.SaveChangesAsync();

            _logger.LogInformation("Successfully imported {Count} transactions.", validRecords.Count);
        }
        _logger.LogInformation("Transaction import completed. Valid: {ValidCount}, Invalid: {InvalidCount}",
            validRecords.Count, invalidRecords.Count);
    }
}

