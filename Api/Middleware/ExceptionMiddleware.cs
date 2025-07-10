using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PFM.Application.DTOs;
using PFM.Application.Exceptions;
using System.Net;
using System.Text.Json;

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

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

            var problemDetails = new ProblemDetails
            {
                Status = context.Response.StatusCode,
                Title = "Database Error",
                Detail = "A database error occurred while processing your request. Please contact support.",
            };

            var options = new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase };
            var json = JsonSerializer.Serialize(problemDetails, options);
            await context.Response.WriteAsync(json);
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
        catch (Exception exception)
        {
            _logger.LogError(exception, "Unhandled exception occurred: {Message}", exception.Message);

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

            var problemDetails = new ProblemDetails
            {
                Status = StatusCodes.Status500InternalServerError,
                Title = "Internal Server Error",
                Detail = "An unexpected error occurred. Please try again later.",
            };

            var options = new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            };

            var json = JsonSerializer.Serialize(problemDetails, options);
            await context.Response.WriteAsync(json);
        }
    }
}
