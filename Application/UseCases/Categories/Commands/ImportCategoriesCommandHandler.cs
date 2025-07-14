
using CsvHelper;
using LoanManagement.Domain.Interfaces;
using MediatR;
using PFM.Application.DTOs;
using PFM.Application.Exceptions;
using PFM.Application.Helpers;
using PFM.Application.Validators;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Globalization;

namespace PFM.Application.UseCases.Categories.Commands;

public class ImportCategoriesCommandHandler : IRequestHandler<ImportCategoriesCommand>
{
    private readonly ICategoryRepository _repository;
    private readonly IUnitOfWork _unitOfWork;

    public ImportCategoriesCommandHandler(ICategoryRepository repository, IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
        _repository = repository;
    }

    public async Task Handle(ImportCategoriesCommand request, CancellationToken cancellationToken)
    {
        // TODO: PROBLEM SA FOREIGN KEY CONSTRAINT - HIJERARHIJA KATEGORIJA
        // 
        // ŠEMA PROBLEMA:
        // - Categories tabela ima self-reference: ParentCode -> Code
        // - EF AddRangeAsync() radi batch insert koji ignoriše redosled
        // - Pokušava da ubaci child kategorije PRE njihovih parent-a
        // - Rezultat: FK constraint error "FK_Categories_Categories_ParentCode"

        using var reader = new StreamReader(request.CsvStream, leaveOpen: true);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        var validator = new CategoryCsvDtoValidator();
        var validationErrors = new List<ValidationErrorDto>();

        var csvRecords = new List<CategoryCsvDto>();

        await foreach (var record in csv.GetRecordsAsync<CategoryCsvDto>(cancellationToken))
        {
            csvRecords.Add(record);
        }

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
                    ParentCode = record.ParentCode
                });
            }
        }

        if (toInsert.Any())
            await _repository.AddRangeAsync(toInsert);

        if (toUpdate.Any())
            await _repository.UpdateRangeAsync(toUpdate);

        await _unitOfWork.SaveChangesAsync();
    }
}

