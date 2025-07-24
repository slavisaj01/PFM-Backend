using MediatR;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using PFM.Application.Common.Exceptions;
using PFM.Application.DTOs;
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
    //[Consumes("application/csv")]
    public async Task<IActionResult> ImportCategories()
    {
        if (!Request.ContentType?.Equals("application/csv", StringComparison.OrdinalIgnoreCase) ?? true)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = new List<ValidationErrorDto>
            {
                new ValidationErrorDto
                {
                    Tag = "content-type",
                    Error = "invalid-format",
                    Message = "Content-Type must be 'application/csv'."
                }
            }
            });
        }

        if (!Request.ContentLength.HasValue || Request.ContentLength.Value == 0)
        {
            throw new ValidationProblemException(new ValidationProblemDto
            {
                Errors = new List<ValidationErrorDto>
            {
                new ValidationErrorDto
                {
                    Tag = "body",
                    Error = "required",
                    Message = "CSV file is required and cannot be empty."
                }
            }
            });
        }

        var command = new ImportCategoriesCommand { CsvStream = Request.Body};

        await _mediator.Send(command);

        return Ok();
    }

}
