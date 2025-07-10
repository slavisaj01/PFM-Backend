using MediatR;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.UseCases.Transactions.Commands;

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

    [HttpGet("test-exception")]
    public IActionResult ThrowTestException()
    {
        throw new Exception("Namerni test izuzetak");
    }

}

