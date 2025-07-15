using FluentValidation;
using PFM.Application.DTOs;

namespace PFM.Application.Common.Interfaces;

public interface ICsvValidationService
{
    List<ValidationErrorDto> ValidateRecords<T>(IEnumerable<T> records,
        IValidator<T> validator, Func<T, string> recordIdSelector = null);
}
