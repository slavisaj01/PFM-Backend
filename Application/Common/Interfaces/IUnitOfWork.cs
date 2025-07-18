
namespace PFM.Application.Common.Interfaces;

public interface IUnitOfWork
{
    Task SaveChangesAsync();
    Task SaveChangesAsync(CancellationToken cancellationToken);
}

