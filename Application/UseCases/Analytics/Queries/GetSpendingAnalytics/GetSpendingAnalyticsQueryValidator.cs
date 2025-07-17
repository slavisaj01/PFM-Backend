
using FluentValidation;
using PFM.Domain.Enums;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsQueryValidator : AbstractValidator<GetSpendingAnalyticsQuery>
{
    public GetSpendingAnalyticsQueryValidator()
    {
        RuleFor(x => x.Direction)
            .Must(dir => dir == "d" || dir == "c")
            .When(x => !string.IsNullOrWhiteSpace(x.Direction))
            .WithMessage("Direction must be 'd' or 'c'");

        RuleFor(x => x.StartDate)
            .Must(BeValidDate).When(x => !string.IsNullOrWhiteSpace(x.StartDate))
            .WithMessage("Invalid date format for start-date");

        RuleFor(x => x.EndDate)
            .Must(BeValidDate).When(x => !string.IsNullOrWhiteSpace(x.EndDate))
            .WithMessage("Invalid date format for end-date");
    }

    private bool BeValidDate(string? date) =>
        DateTime.TryParse(date, out _);
}
