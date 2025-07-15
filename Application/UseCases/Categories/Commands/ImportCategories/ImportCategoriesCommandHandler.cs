
using CsvHelper;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;
using PFM.Application.Common.Exceptions;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using AutoMapper;

namespace PFM.Application.UseCases.Categories.Commands.ImportCategories;

public class ImportCategoriesCommandHandler : IRequestHandler<ImportCategoriesCommand>
{
    private readonly ICategoryRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;
    private readonly ICsvValidationService _validationService;

    public ImportCategoriesCommandHandler(ICategoryRepository repository, IUnitOfWork unitOfWork, 
        ICsvParser csvParser, IMapper mapper, ICsvValidationService csvValidation)
    {
        _unitOfWork = unitOfWork;
        _repository = repository;
        _csvParser = csvParser;
        _mapper = mapper;
        _validationService = csvValidation;
    }

    public async Task Handle(ImportCategoriesCommand request, CancellationToken cancellationToken)
    {

        var csvRecords = await _csvParser.ParseAsync<CategoryCsvDto>(request.CsvStream, cancellationToken);

        Console.WriteLine($"Parsed {csvRecords.Count} records:");
        foreach (var record in csvRecords)
        {
            Console.WriteLine($"Code: '{record.Code}', Parent: '{record.ParentCode}', Name: '{record.Name}'");
        }


        var validator = new ImportCategoryCsvDtoValidator();
        var validationErrors = _validationService.ValidateRecords(csvRecords, validator,
            r => r.Code);

        if (validationErrors.Count != 0)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = validationErrors
            });
        }

        var codes = csvRecords.Select(r => r.Code).Distinct().ToList();

        var existingCategories = await _repository.GetByCodesAsync(codes);

        var toInsert = new List<Category>();
        var toUpdate = new List<Category>();

        foreach (var record in csvRecords)
        {
            var existing = existingCategories.FirstOrDefault(c => c.Code == record.Code);
            //moze i dictionari ovako je O(n),dictionary O(1)

            if (existing is not null)
            {
                existing.Name = record.Name;
                existing.ParentCode = string.IsNullOrWhiteSpace(record.ParentCode) ? null : record.ParentCode;
                toUpdate.Add(existing);
            }
            else
            {
                var category = _mapper.Map<Category>(record);
                toInsert.Add(category);
            }
        }

        if (toInsert.Any())
            await _repository.AddRangeAsync(toInsert);

        if (toUpdate.Any())
            await _repository.UpdateRangeAsync(toUpdate);

        await _unitOfWork.SaveChangesAsync();
    }
}

