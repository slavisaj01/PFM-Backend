using AutoMapper;
using CsvHelper;
using MediatR;
using Microsoft.Extensions.Logging;
using PFM.Application.Common;
using PFM.Application.Common.Constants;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Text;

namespace PFM.Application.UseCases.Categories.Commands.ImportCategories;

public class ImportCategoriesCommandHandler : IRequestHandler<ImportCategoriesCommand>
{
    private readonly ICategoryRepository _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;

    public ImportCategoriesCommandHandler(ICategoryRepository repository, IUnitOfWork unitOfWork,
        ICsvParser csvParser, IMapper mapper)
    {
        _unitOfWork = unitOfWork;
        _repository = repository;
        _csvParser = csvParser;
        _mapper = mapper;
    }

    public async Task Handle(ImportCategoriesCommand request, CancellationToken cancellationToken)
    {
        List<CategoryCsvDto> csvRecords;

        try
        {
            csvRecords = await _csvParser.ParseAsync<CategoryCsvDto>(request.CsvStream, cancellationToken);
        }
        catch (CsvHelperException)
        {
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.CsvParsingError,
                "Ensure the CSV file has the correct delimiter, headers, and consistent structure."
            );
        }

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

        if (invalidRecords.Any())
        {
            Directory.CreateDirectory("logs");

            var logBuilder = new StringBuilder();

            var timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            logBuilder.AppendLine($"=== Invalid categories at {timestamp} ===");
            logBuilder.AppendLine();

            foreach (var (record, errors) in invalidRecords)
            {
                logBuilder.AppendLine($"(Code: {(!string.IsNullOrWhiteSpace(record.Code) ? record.Code : "<empty>")})");

                foreach (var error in errors)
                {
                    logBuilder.AppendLine($" - {error.Tag}: {error.Message}");
                }

                logBuilder.AppendLine();
            }

            logBuilder.AppendLine($"Imported: {validRecords.Count} / Skipped: {invalidRecords.Count}");
            logBuilder.AppendLine("--------------------");
            logBuilder.AppendLine();

            await File.AppendAllTextAsync("logs/invalid-categories.txt", logBuilder.ToString());
        }

        if (validRecords.Any())
        {
            var codes = validRecords
                .Where(r => !string.IsNullOrWhiteSpace(r.Code))
                .Select(r => r.Code!)
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();
            var existingCategories = await _repository.GetByCodesAsync(codes);

            var existingDict = existingCategories.ToDictionary(c => c.Code, StringComparer.OrdinalIgnoreCase);

            var toInsert = new List<Category>();
            var toUpdate = new List<Category>();

            foreach (var record in validRecords)
            {
                if (!string.IsNullOrWhiteSpace(record.Code) &&
                        existingDict.TryGetValue(record.Code, out var existing))
                {
                    if (!string.IsNullOrWhiteSpace(record.Name))
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
}

