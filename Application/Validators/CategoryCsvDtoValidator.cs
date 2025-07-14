using FluentValidation;
using PFM.Application.DTOs;

namespace PFM.Application.Validators;

public class CategoryCsvDtoValidator : AbstractValidator<CategoryCsvDto>
{
    public CategoryCsvDtoValidator()
    {
        RuleFor(c => c.Code)
            .NotEmpty().WithMessage("Code is required.")
            .MaximumLength(50);

        RuleFor(c => c.Name)
            .NotEmpty().WithMessage("Name is required.")
            .MaximumLength(200);

        RuleFor(c => c.ParentCode)
            .MaximumLength(50)
            .When(c => !string.IsNullOrWhiteSpace(c.ParentCode));
    }
}
