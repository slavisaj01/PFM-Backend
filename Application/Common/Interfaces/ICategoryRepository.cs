using PFM.Domain.Entities;

namespace PFM.Domain.Interfaces;

public interface ICategoryRepository
{
    Task AddRangeAsync(IEnumerable<Category> categories);
    Task<Category?> GetByCodeAsync(string code);
    Task AddAsync(Category category);
    Task UpdateRangeAsync(IEnumerable<Category> categories);
    Task<List<Category>> GetByCodesAsync(IEnumerable<string> codes);
    Task<List<string>> GetExistingCatcodesAsync(IEnumerable<string> catcodes);
    Task<List<Category>> GetAllAsync(CancellationToken cancellationToken);
}

