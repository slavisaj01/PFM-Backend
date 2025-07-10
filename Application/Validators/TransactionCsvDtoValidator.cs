using FluentValidation;
using PFM.Application.DTOs;
using PFM.Domain.Constants;
using PFM.Domain.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Application.Validators;

    public class TransactionCsvDtoValidator : AbstractValidator<TransactionCsvDto>
    {
    public TransactionCsvDtoValidator()
    {
        RuleFor(x => x.Id).NotEmpty();
        RuleFor(x => x.Date).NotEmpty();
        RuleFor(x => x.Direction)
            .Must(val => Enum.TryParse<Direction>(val, true, out _))
            .WithMessage("Direction must be 'd' or 'c'");
        RuleFor(x => x.Amount).NotEmpty().GreaterThan(0);
        RuleFor(x => x.Currency).NotEmpty();
        RuleFor(x => x.Kind)
            .Must(val => Enum.TryParse<TransactionKind>(val, true, out _))
            .WithMessage("Invalid Kind value");
        RuleFor(x => x.Mcc)
            .Must(mcc => mcc == null || MccCodes.IsValid(mcc.Value))
            .WithMessage("Provided MCC is not valid");
    }
}

