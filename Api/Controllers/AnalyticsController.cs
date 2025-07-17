using MediatR;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

namespace PFM.Api.Controllers;

[ApiController]
[Route("[controller]")]
public class AnalyticsController : ControllerBase
{
    private readonly IMediator _mediator;

    public AnalyticsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpGet("spending-analytics")]
    public async Task<ActionResult<GetSpendingAnalyticsResponse>> GetSpendingAnalytics(
        [FromQuery] GetSpendingAnalyticsQuery query)
    {
        var result = await _mediator.Send(query);
        return Ok(result);
    }

}
