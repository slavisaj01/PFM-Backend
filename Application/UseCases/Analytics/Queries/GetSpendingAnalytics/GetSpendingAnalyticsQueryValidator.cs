
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
            .WithMessage("StartDate must be less than or equal to EndDate.")
            .WithErrorCode("out-of-range")
            .WithState(_ => "start-date");


    }

    private bool BeValidDate(string? date) =>
        DateTime.TryParse(date, out _);
}
