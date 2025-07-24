using FluentValidation;

namespace PFM.Application.UseCases.Transactions.Queries.GetTransactions;

public class GetTransactionsQueryValidator : AbstractValidator<GetTransactionsQuery>
{
    private static readonly string[] ValidTransactionKinds =
    {
        "dep", "wdw", "pmt", "fee", "inc", "rev", "adj",
        "lnd", "lnr", "fcx", "aop", "acl", "spl", "sal"
    };

    public GetTransactionsQueryValidator()
    {
        RuleFor(x => x.PageNumber)
            .GreaterThan(0).WithMessage("page-number must be greater than 0.");

        RuleFor(x => x.PageSize)
            .InclusiveBetween(1, 100).WithMessage("page-size must be between 1 and 100.");

        RuleFor(x => x.SortOrder)
            .Must(x => x == null || x.ToLower() is "asc" or "desc")
            .WithMessage("sort-order must be 'asc' or 'desc'.");

        RuleFor(x => x.SortBy)
            .Must(x => x == null || new[] { "amount", "date", "beneficiary-name" }.Contains(x.ToLower()))
            .WithMessage("sort-by must be 'amount', 'date', or 'beneficiary-name'.");

        RuleFor(x => x.StartDate)
            .Must(BeAValidDateTime)
            .When(x => !string.IsNullOrWhiteSpace(x.StartDate))
            .WithMessage("start-date must be a valid ISO 8601 date-time.");

        RuleFor(x => x.EndDate)
            .Must(BeAValidDateTime)
            .When(x => !string.IsNullOrWhiteSpace(x.EndDate))
            .WithMessage("end-date must be a valid ISO 8601 date-time.");

        RuleFor(x => x)
            .Must(x =>
            {
                if (!string.IsNullOrWhiteSpace(x.StartDate) && !string.IsNullOrWhiteSpace(x.EndDate) &&
                    DateTime.TryParse(x.StartDate, out var start) &&
                    DateTime.TryParse(x.EndDate, out var end))
                {
                    return start <= end;
                }

                return true; // preskoči ako nije validan datum (biće uhvaćen u prethodnim pravilima)
            })
            .WithMessage("start-date must be less than or equal to EndDate.")
            .WithErrorCode("invalid-range")
            .WithState(_ => "start-date");


        RuleFor(x => x.TransactionKinds)
            .Cascade(CascadeMode.Stop)
            .NotNull()
            .Must(kinds => kinds.All(k => ValidTransactionKinds.Contains(k.ToLower())))
            .WithMessage("transaction-kind must be one of the allowed values.")
            .WithState(_ => "transaction-kind");

    }

    private bool BeAValidDateTime(string value)
    {
        return DateTime.TryParse(value, out _);
    }
}


