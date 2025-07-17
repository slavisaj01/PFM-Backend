namespace PFM.Application.Common.Interfaces;

public interface ICsvParser
{
    Task<List<T>> ParseAsync<T>(Stream csvStream, CancellationToken cancellationToken);
}
