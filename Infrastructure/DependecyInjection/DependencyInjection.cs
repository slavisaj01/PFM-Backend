using LoanManagement.Domain.Interfaces;
using LoanManagement.Infrastructure.Persistence;
using Microsoft.Extensions.DependencyInjection;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Persistence.Repositories;

namespace PFM.Infrastructure.DependecyInjection;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services)
    {
        services.AddScoped<ITransactionRepository, TransactionRepository>();
        services.AddScoped<IUnitOfWork, UnitOfWork>();

        return services;
    }

    public static IServiceCollection AddApplicationServices(this IServiceCollection services)
    {

        return services;
    }
}

