using MediatR;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.UseCases.Transactions.Queries.GetTransactions;
using PFM.Application.UseCases.Transactions.Commands.ImportTransactions;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;

namespace PFM.Api.Controllers;

[ApiController]
[Route("transactions")]
public class TransactionsController : ControllerBase
{
    private readonly IMediator _mediator;
    public TransactionsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("import")]
    [Consumes("application/csv")]
    public async Task<IActionResult> ImportTransactions()
    {
        var command = new ImportTransactionsCommand { CsvStream = Request.Body };

        await _mediator.Send(command);

        return Ok();
    }
    [HttpGet]
    public async Task<ActionResult<GetTransactionsResponse>> GetTransactions(
        [FromQuery] GetTransactionsQuery getTransactionsQuery)
    {
        var transaction = await _mediator.Send(getTransactionsQuery);
        return Ok(transaction);
    }

    [HttpGet("test-exception")]
    public IActionResult ThrowTestException()
    {
        throw new Exception("Namerni test izuzetak");
    }

}

