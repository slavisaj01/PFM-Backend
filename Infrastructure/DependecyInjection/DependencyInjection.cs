using FluentValidation;
using LoanManagement.Domain.Interfaces;
using LoanManagement.Infrastructure.Persistence;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PFM.Application.Common.Behaviors;
using PFM.Application.Common.Interfaces;
using PFM.Application.Common.Mappings;
using PFM.Application.Common.Services;
using PFM.Application.UseCases.Transactions.Queries.GetTransactions;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Parsers;
using PFM.Infrastructure.Persistence.Data;
using PFM.Infrastructure.Persistence.Repositories;

namespace PFM.Infrastructure.DependecyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(
        this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

        services.AddScoped<ITransactionRepository, TransactionRepository>();
        services.AddScoped<ICategoryRepository, CategoryRepository>();
        services.AddScoped<IUnitOfWork, UnitOfWork>();
        services.AddScoped<ICsvParser, CsvParser>();

        return services;
    }

    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddMediatR(cfg =>
            cfg.RegisterServicesFromAssembly(typeof(PFM.Application.AssemblyMarker).Assembly));

        services.AddValidatorsFromAssemblyContaining<GetTransactionsQueryValidator>();
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));

        services.AddAutoMapper(cfg => { }, typeof(CategoryProfile).Assembly);

        services.AddScoped<ICsvValidationService, CsvValidationService>();

        return services;
    }
}

