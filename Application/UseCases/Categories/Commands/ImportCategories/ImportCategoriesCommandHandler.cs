using CsvHelper;
using PFM.Application.Common.Interfaces;
using MediatR;
using PFM.Application.Common.Helpers;
using PFM.Application.DTOs;
using PFM.Application.Common.Exceptions;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using AutoMapper;
using Microsoft.Extensions.Logging;

namespace PFM.Application.UseCases.Categories.Commands.ImportCategories;

public class ImportCategoriesCommandHandler : IRequestHandler<ImportCategoriesCommand>
{
    private readonly ICategoryRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;
    private readonly ILogger<ImportCategoriesCommandHandler> _logger;

    public ImportCategoriesCommandHandler(ICategoryRepository repository, IUnitOfWork unitOfWork, 
        ICsvParser csvParser, IMapper mapper,
        ILogger<ImportCategoriesCommandHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _repository = repository;
        _csvParser = csvParser;
        _mapper = mapper;
        _logger = logger;
    }

    public async Task Handle(ImportCategoriesCommand request, CancellationToken cancellationToken)
    {

        var csvRecords = await _csvParser.ParseAsync<CategoryCsvDto>(request.CsvStream, cancellationToken);

        
        var validator = new ImportCategoryCsvDtoValidator();

        var validRecords = new List<CategoryCsvDto>();
        var invalidRecords = new List<(CategoryCsvDto Record, List<ValidationErrorDto> Errors)>();

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
            _logger.LogWarning("Invalid category record (Code: {Code}):", string
                    .IsNullOrWhiteSpace(record.Code) ? "<empty>" : record.Code); ;

            foreach (var error in errors)
            {
                _logger.LogWarning(" - {Tag}: {Message}", error.Tag, error.Message);
            }
        }

        if (validRecords.Any())
        {
            var codes = validRecords.Select(r => r.Code).Distinct().ToList();
            var existingCategories = await _repository.GetByCodesAsync(codes);

            var existingDict = existingCategories.ToDictionary(c => c.Code, StringComparer.OrdinalIgnoreCase);

            var toInsert = new List<Category>();
            var toUpdate = new List<Category>();

            foreach (var record in validRecords)
            {
                if (existingDict.TryGetValue(record.Code, out var existing))
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

            _logger.LogInformation("Successfully imported {Count} categories.", validRecords.Count);
        }

        _logger.LogInformation("Category import completed. Valid: {ValidCount}, Invalid: {InvalidCount}",
            validRecords.Count, invalidRecords.Count);

    }
}

