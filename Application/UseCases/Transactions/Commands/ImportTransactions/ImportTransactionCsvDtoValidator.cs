using FluentValidation;
using PFM.Application.DTOs;
using PFM.Domain.Constants;
using PFM.Domain.Enums;

namespace PFM.Application.UseCases.Transactions.Commands.ImportTransactions;

public class ImportTransactionCsvDtoValidator : AbstractValidator<TransactionCsvDto>
{
    public ImportTransactionCsvDtoValidator()
    {
        RuleFor(x => x.Id).NotEmpty();
        RuleFor(x => x.Date)
            .NotEmpty().WithMessage("'Date' must not be empty.")
            .DependentRules(() =>
            {
                RuleFor(x => x.Date)
               .Must(date => DateTime.TryParse(date, out _))
               .WithMessage("Invalid date format");
            });
        RuleFor(x => x.Direction)
            .NotEmpty().WithMessage("'Direction' must not be empty.")
            .DependentRules(() =>
            {
                RuleFor(x => x.Direction)
             .Must(val => Enum.TryParse<Direction>(val, true, out _))
             .WithMessage("Direction must be 'd' or 'c'");
            });
        RuleFor(x => x.Amount).NotEmpty().GreaterThan(0);
        RuleFor(x => x.Currency).NotEmpty().MinimumLength(3).MaximumLength(3);
        RuleFor(x => x.Kind)
            .NotEmpty().WithMessage("'Kind' must not be empty.")
            .DependentRules(() =>
            {
             RuleFor(x => x.Kind)
            .Must(val => Enum.TryParse<TransactionKind>(val, true, out _))
            .WithMessage("Invalid Kind value");
            });
        RuleFor(x => x.Mcc)
            .Must(mcc => mcc == null || MccCodes.IsValid(mcc.Value))
            .WithMessage("Provided MCC is not valid");
    }
}

