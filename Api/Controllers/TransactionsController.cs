using MediatR;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.DTOs;
using PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;
using PFM.Application.UseCases.Transactions.Commands.ImportTransactions;
using PFM.Application.UseCases.Transactions.Commands.SplitTransaction;
using PFM.Application.UseCases.Transactions.Queries.GetTransactions;
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
    [FromQuery(Name = "transaction-kind")] List<string>? kinds,
    [FromQuery(Name = "start-date")] string? startDate,
    [FromQuery(Name = "end-date")] string? endDate,
    [FromQuery(Name = "sort-by")] string? sortBy,
    [FromQuery(Name = "sort-order")] string? sortOrder,
    [FromQuery(Name = "page-number")] int pageNumber = 1,
    [FromQuery(Name = "page-size")] int pageSize = 10)
    {
        var query = new GetTransactionsQuery
        {
            TransactionKinds = kinds,
            StartDate = startDate,
            EndDate = endDate,
            SortBy = sortBy,
            SortOrder = sortOrder,
            PageNumber = pageNumber,
            PageSize = pageSize
        };

        var result = await _mediator.Send(query);
        return Ok(result);
    }

    [HttpPost("{id}/categorize")]
    public async Task<IActionResult> TransactionCategorize(string id,
        [FromBody] TransactionCategorizeCommandDto dto)
    {
        var command = new CategorizeTransactionCommand { Id = id, Catcode = dto.Catcode };
        await _mediator.Send(command);
        return Ok();
    }

    [HttpPost("{id}/split")]
    public async Task<IActionResult> SplitTransaction(string id, [FromBody] List<TransactionSplitDto> splits)
    {
        var command = new SplitTransactionCommand
        {
            Id = id,
            Splits = splits
        };

        await _mediator.Send(command);
        return Ok();
    }

    [HttpGet("test-exception")]
    public IActionResult ThrowTestException()
    {
        throw new Exception("Namerni test izuzetak");
    }

}

