using FluentValidation;

namespace PFM.Application.UseCases.Transactions.Commands.SplitTransaction;

public class SplitTransactionCommandValidator : AbstractValidator<SplitTransactionCommand>
{
    public SplitTransactionCommandValidator()
    {
        Console.WriteLine("Validator created");
        RuleFor(x => x.Splits)
            .NotNull().WithMessage("Splits are required.")
            .NotEmpty().WithMessage("At least one split is required.");

        RuleForEach(x => x.Splits).ChildRules(split =>
        {
            split.RuleFor(s => s.Catcode)
                .NotEmpty().WithMessage("Catcode is required.");

            split.RuleFor(s => s.Amount)
                .GreaterThan(0).WithMessage("Amount must be greater than 0.");
        });

        Console.WriteLine("SplitTransactionCommandValidator created");
    }
}