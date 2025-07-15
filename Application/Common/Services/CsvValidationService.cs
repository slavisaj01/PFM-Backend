using FluentValidation;
using PFM.Application.Common.Helpers;
using PFM.Application.Common.Interfaces;
using PFM.Application.DTOs;

namespace PFM.Application.Common.Services;

public class CsvValidationService : ICsvValidationService
{
    public List<ValidationErrorDto> ValidateRecords<T>(IEnumerable<T> records, IValidator<T> validator, Func<T, string> recordIdSelector = null)
    {
        var validationErrors = new List<ValidationErrorDto>();

        foreach (var record in records)
        {
            var result = validator.Validate(record);
            if (!result.IsValid)
            {
                var recordId = recordIdSelector?.Invoke(record);

                foreach (var error in result.Errors)
                {
                    validationErrors.Add(new ValidationErrorDto
                    {
                        Tag = error.PropertyName,
                        Error = ValidationErrorMapper.Map(error),
                        Message = string.IsNullOrWhiteSpace(recordId)
                            ? $"Invalid record: {error.ErrorMessage}"
                            : $"Invalid record {recordId}: {error.ErrorMessage}"
                    });
                }
            }
        }

        return validationErrors;
    }
}
