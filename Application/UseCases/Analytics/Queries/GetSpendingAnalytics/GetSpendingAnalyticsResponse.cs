
using PFM.Application.DTOs;
using System.Text.Json.Serialization;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsResponse
{
    [JsonPropertyName("groups")]
    public List<SpendingInCategoryDto> Groups { get; set; } = [];
}
