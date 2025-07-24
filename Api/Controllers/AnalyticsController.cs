using MediatR;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

namespace PFM.Api.Controllers;

[ApiController]
public class AnalyticsController : ControllerBase
{
    private readonly IMediator _mediator;

    public AnalyticsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("/spending-analytics")]
    public async Task<ActionResult<GetSpendingAnalyticsResponse>> GetSpendingAnalytics(
    [FromQuery(Name = "cat-code")] string? catCode,
    [FromQuery(Name = "direction")] string? direction,
    [FromQuery(Name = "start-date")] string? startDate,
    [FromQuery(Name = "end-date")] string? endDate)
    {
        var query = new GetSpendingAnalyticsQuery
        {
            Catcode = catCode,
            Direction = direction,
            StartDate = startDate,
            EndDate = endDate
        };

        var result = await _mediator.Send(query);
        return Ok(result);
    }

}
