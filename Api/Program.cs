using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PFM.Api.Middleware;
using PFM.Application.Common.Utilities;
using PFM.Application.DTOs;
using PFM.Infrastructure.DependecyInjection;
using PFM.Infrastructure.Persistence.Data;
using Serilog;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Api;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers()
            .AddJsonOptions(options =>
            {
                options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()); // Enum kao string
                options.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.KebabCaseLower; // camelCase -> kebab-case
            });

        builder.Services.AddCors(options =>
        {
            options.AddPolicy("AllowDevClients", policy =>
            {
                policy.WithOrigins(
                          "http://localhost:4200",
                          "http://127.0.0.1:5500"
                      )
                      .AllowAnyMethod()
                      .AllowAnyHeader()
                      .AllowCredentials();
            });
        });

        builder.Services.Configure<ApiBehaviorOptions>(options =>
        {
            options.InvalidModelStateResponseFactory = context =>
            {
                var errors = context.ModelState
                    .Where(x => x.Value?.Errors?.Count > 0)
                    .SelectMany(kvp => kvp.Value!.Errors.Select(err => new ValidationErrorDto
                    {
                        Tag = StringExtensions.ToKebabCase(kvp.Key),
                        Error = "invalid-format",
                        Message = err.ErrorMessage
                    }))
                    .ToList();

                return new BadRequestObjectResult(new ValidationProblemDto { Errors = errors });
            };
        });

        builder.Services.AddInfrastructureServices(builder.Configuration);
        builder.Services.AddApplicationServices();
        builder.Services.AddSwaggerGen();

        Log.Logger = new LoggerConfiguration()
            .ReadFrom.Configuration(builder.Configuration)
            .CreateLogger();
        builder.Host.UseSerilog();


        var app = builder.Build();

        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }


        app.UseHttpsRedirection();

        app.UseCors("AllowDevClients");

        app.UseMiddleware<ExceptionMiddleware>();

        app.UseAuthorization();


        app.MapControllers();

        UpdateDatabase(app);

        app.Run();

        static void UpdateDatabase(IApplicationBuilder app)
        {
            using var serviceScope = app.ApplicationServices.CreateScope();
            using var context = serviceScope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
            context.Database.Migrate();
        }
    }
}

