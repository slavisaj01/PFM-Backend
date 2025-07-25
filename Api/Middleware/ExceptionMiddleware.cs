using Microsoft.EntityFrameworkCore;
using PFM.Application.Common.Exceptions;
using PFM.Application.DTOs;
using System.Net;

namespace PFM.Api.Middleware;

public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionMiddleware> _logger;

    public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (DbUpdateException dbEx)
        {
            _logger.LogError(dbEx, "Database update failed");

            context.Response.StatusCode = 503;
            context.Response.ContentType = "application/json";

            var error = new ValidationProblemDto
            { 
                Errors = new List<ValidationErrorDto>
                {
                    new ValidationErrorDto
                    {
                        Tag = "database",
                        Error = "service-unavailable",
                        Message = "A database error occurred while processing your request. Please contact support."
                    }
                }
            };

            await context.Response.WriteAsJsonAsync(error);
        }
        catch (BusinessException ex)
        {
            _logger.LogWarning(ex, "Business exception occurred");

            context.Response.StatusCode = 440;
            context.Response.ContentType = "application/json";

            var dto = new BusinessProblemDto
            {
                Problem = ex.Problem,
                Message = ex.Message,
                Details = ex.Details
            };

            await context.Response.WriteAsJsonAsync(dto);
        }
        catch (ValidationProblemException ex)
        {
            _logger.LogWarning(ex, "Custom validation problem occurred");

            context.Response.StatusCode = 400;
            context.Response.ContentType = "application/json";

            await context.Response.WriteAsJsonAsync(ex.Validation);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Unhandled exception occurred: {Message}", ex.Message);

            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            context.Response.ContentType = "application/json";

            var error = new ValidationProblemDto
            {
                Errors = new List<ValidationErrorDto>
                {
                    new ValidationErrorDto
                    {
                        Tag = "general",
                        Error = "invalid-format",
                        Message = "An unexpected error occurred. Please try again later."
                    }
                }
            };

            await context.Response.WriteAsJsonAsync(error);
        }
    }
}
