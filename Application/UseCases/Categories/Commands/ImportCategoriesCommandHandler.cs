
using CsvHelper;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.DTOs;
using PFM.Application.Exceptions;
using PFM.Application.Helpers;
using PFM.Application.Interfaces;
using PFM.Application.Validators;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Globalization;

namespace PFM.Application.UseCases.Categories.Commands;

public class ImportCategoriesCommandHandler : IRequestHandler<ImportCategoriesCommand>
{
    private readonly ICategoryRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;

    public ImportCategoriesCommandHandler(ICategoryRepository repository,
        IUnitOfWork unitOfWork, ICsvParser csvParser)
    {
        _unitOfWork = unitOfWork;
        _repository = repository;
        _csvParser = csvParser;
    }

    public async Task Handle(ImportCategoriesCommand request, CancellationToken cancellationToken)
    {

        var csvRecords = await _csvParser.ParseAsync<CategoryCsvDto>(request.CsvStream, cancellationToken);

        var validator = new CategoryCsvDtoValidator();
        var validationErrors = new List<ValidationErrorDto>();

        foreach (var record in csvRecords)
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
                        Message = $"Invalid record CODE {record.Code}: {error.ErrorMessage}"
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

        var codes = csvRecords.Select(r => r.Code).Distinct().ToList();

        var existingCategories = await _repository.GetByCodesAsync(codes);

        var toInsert = new List<Category>();
        var toUpdate = new List<Category>();

        foreach (var record in csvRecords)
        {
            var existing = existingCategories.FirstOrDefault(c => c.Code == record.Code);
            if (existing != null)
            {
                existing.Name = record.Name;
                existing.ParentCode = record.ParentCode;
                toUpdate.Add(existing);
            }
            else
            {
                toInsert.Add(new Category
                {
                    Code = record.Code,
                    Name = record.Name,
                    ParentCode = string.IsNullOrWhiteSpace(record.ParentCode)
                        ? null : record.ParentCode
                });
            }
        }

        if (toInsert.Any())
            await _repository.AddRangeAsync(toInsert);

        if (toUpdate.Any())
            await _repository.UpdateRangeAsync(toUpdate);

        foreach (var category in toInsert)
        {
            Console.WriteLine($"Code: {category.Code}, ParentCode: '{category.ParentCode}'");
        }

        await _unitOfWork.SaveChangesAsync();
    }
}

