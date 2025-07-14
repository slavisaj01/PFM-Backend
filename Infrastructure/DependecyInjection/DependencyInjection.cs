using FluentValidation;
using LoanManagement.Domain.Interfaces;
using LoanManagement.Infrastructure.Persistence;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using PFM.Application.Common.Behaviors;
using PFM.Application.Validators;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Persistence.Repositories;

namespace PFM.Infrastructure.DependecyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services)
    {
        services.AddScoped<ITransactionRepository, TransactionRepository>();
        services.AddScoped<ICategoryRepository, CategoryRepository>();
        services.AddScoped<IUnitOfWork, UnitOfWork>();

        return services;
    }

    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {
        services.AddValidatorsFromAssemblyContaining<GetTransactionsQueryValidator>();
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
        return services;
    }
}

