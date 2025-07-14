
namespace PFM.Application.Interfaces;

public interface ICsvParser
{
    Task<List<T>> ParseAsync<T>(Stream csvStream, CancellationToken cancellationToken);
}
