using FluentValidation;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using PFM.Application.Common.Behaviors;
using PFM.Application.Common.Interfaces;
using PFM.Application.Common.Mappings;
using PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;
using PFM.Application.UseCases.Transactions.Commands.SplitTransaction;
using PFM.Application.UseCases.Transactions.Queries.GetTransactions;
using PFM.Domain.Common.Services;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Parsers;
using PFM.Infrastructure.Persistence.Data;
using PFM.Infrastructure.Persistence.Repositories;
using PFM.Infrastructure.Services;

namespace PFM.Infrastructure.DependecyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(
        this IServiceCollection services, IConfiguration configuration)
    {
        services.AddDbContext<ApplicationDbContext>(options =>
            options.UseNpgsql(configuration.GetConnectionString("DefaultConnection")));

        services.AddScoped<ITransactionRepository, TransactionRepository>();
        services.AddScoped<ICategoryRepository, CategoryRepository>();
        services.AddScoped<ITransactionSplitRepository, TransactionSplitRepository>();
        services.AddScoped<IUnitOfWork, UnitOfWork>();
        services.AddScoped<ICsvParser, CsvParser>();

        services.AddSingleton<IAutoCategorizationRuleProvider, JsonAutoCategorizationRuleProvider>();

        return services;
    }

    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddMediatR(cfg =>
            cfg.RegisterServicesFromAssembly(typeof(PFM.Application.AssemblyMarker).Assembly));

        services.AddValidatorsFromAssemblyContaining<GetTransactionsQueryValidator>();
        services.AddValidatorsFromAssemblyContaining<GetSpendingAnalyticsQueryValidator>();
        services.AddValidatorsFromAssemblyContaining<SplitTransactionCommandValidator>();
        services.AddValidatorsFromAssemblyContaining<CategorizeTransactionCommandValidator>();

        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));


        services.AddAutoMapper(cfg => { }, typeof(CategoryProfile).Assembly);

        services.AddScoped<ICategoryDomainService, CategoryDomainService>();

        return services;
    }
}

