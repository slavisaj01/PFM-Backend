using FluentValidation;

namespace PFM.Application.UseCases.Transactions.Queries.GetTransactions;

public class GetTransactionsQueryValidator : AbstractValidator<GetTransactionsQuery>
{
    public GetTransactionsQueryValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThan(0).WithMessage("Page must be greater than 0.");

        RuleFor(x => x.PageSize)
            .InclusiveBetween(1, 100).WithMessage("PageSize must be between 1 and 100.");

        RuleFor(x => x.SortOrder)
            .Must(x => x == null || x.ToLower() is "asc" or "desc")
            .WithMessage("SortOrder must be 'asc' or 'desc'.");

        RuleFor(x => x.SortBy)
            .Must(x => x == null || new[] { "amount", "date", "beneficiary-name" }.Contains(x.ToLower()))
            .WithMessage("SortBy must be 'amount', 'date', or 'beneficiary-name'.");

        RuleFor(x => x.StartDate)
            .Must(BeAValidDateTime)
            .When(x => !string.IsNullOrWhiteSpace(x.StartDate))
            .WithMessage("StartDate must be a valid ISO 8601 date-time.");

        RuleFor(x => x.EndDate)
            .Must(BeAValidDateTime)
            .When(x => !string.IsNullOrWhiteSpace(x.EndDate))
            .WithMessage("EndDate must be a valid ISO 8601 date-time.");
    }

    private bool BeAValidDateTime(string value)
    {
        return DateTime.TryParse(value, out _);
    }

}


