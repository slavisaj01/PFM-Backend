using FluentValidation;

using PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;

public class CategorizeTransactionCommandValidator : AbstractValidator<CategorizeTransactionCommand>
{
    public CategorizeTransactionCommandValidator()
    {
        RuleFor(x => x.Id)
            .NotEmpty().WithMessage("Transaction ID is required.");

        RuleFor(x => x.Catcode)
            .NotEmpty().WithMessage("Category code is required.");
    }
}
