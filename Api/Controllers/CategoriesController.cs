using MediatR;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.UseCases.Categories.Commands.ImportCategories;

namespace PFM.Api.Controllers;

[ApiController]
[Route("categories")]
public class CategoriesController : ControllerBase
{
    private readonly IMediator _mediator;

    public CategoriesController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("import")]
    [Consumes("application/csv")]
    public async Task<IActionResult> ImportCategories()
    {
        var command = new ImportCategoriesCommand { CsvStream = Request.Body};

        await _mediator.Send(command);

        return Ok();
    }

}
