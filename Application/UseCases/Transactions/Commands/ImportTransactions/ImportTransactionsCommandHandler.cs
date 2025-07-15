using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;
using PFM.Application.Common.Exceptions;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;
using AutoMapper;


namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionsCommandHandler : IRequestHandler<ImportTransactionsCommand>
{
    private readonly ITransactionRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;
    private readonly ICsvValidationService _validationService;

    public ImportTransactionsCommandHandler(ITransactionRepository repository, IUnitOfWork unitOfWork,
        ICsvParser csvParser, IMapper mapper, ICsvValidationService validationService)
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
        _csvParser = csvParser;
        _mapper = mapper;
        _validationService = validationService;
    }

    public async Task Handle(ImportTransactionsCommand request, CancellationToken cancellationToken)
    {
        var csvRecords = await _csvParser.ParseAsync<TransactionCsvDto>
            (request.CsvStream, cancellationToken);

        var validator = new ImportTransactionCsvDtoValidator();//mozda DI umesto rucno kreiranje
        var validationErrors = _validationService.ValidateRecords(csvRecords, validator, 
            record => record.Id);

        if (validationErrors.Count != 0)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = validationErrors
            });
        }

        var transactions = _mapper.Map<List<Transaction>>(csvRecords);

        await _repository.AddRangeAsync(transactions);
        await _unitOfWork.SaveChangesAsync();
    }
}

