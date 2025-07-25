using MediatR;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsQuery : IRequest<GetSpendingAnalyticsResponse>
{
    public string? Catcode { get; set; }
    public string? StartDate { get; set; } 
    public string? EndDate { get; set; }   
    public string? Direction { get; set; }
}
