
using Microsoft.EntityFrameworkCore;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Persistence.Data;

namespace PFM.Infrastructure.Persistence.Repositories;

public class CategoryRepository : ICategoryRepository
{
    private readonly ApplicationDbContext _dbContext;

    public CategoryRepository(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task AddAsync(Category category)
    {
        await _dbContext.Categories.AddAsync(category);
    }

    public async Task AddRangeAsync(IEnumerable<Category> categories)
    {
        await _dbContext.Categories.AddRangeAsync(categories);
    }

    public async Task<List<Category>> GetAllAsync(CancellationToken cancellationToken)
    {
        return await _dbContext.Categories
            .AsNoTracking()// sta ovo znaci nauci obavezno!!!!!
            .ToListAsync(cancellationToken);
    }

    public async Task<Category?> GetByCodeAsync(string code)
    {
        return await _dbContext.Categories
            .Include(c => c.Parent)
            .FirstOrDefaultAsync(c => c.Code == code);
    }

    public async Task<List<Category>> GetByCodesAsync(IEnumerable<string> codes)
    {
        return await _dbContext.Categories
        .Where(c => codes.Contains(c.Code))
        .ToListAsync();
    }

    public async Task<List<string>> GetExistingCatcodesAsync(IEnumerable<string> catcodes)
    {
        return await _dbContext.Categories
        .Where(c => catcodes.Contains(c.Code))
        .Select(c => c.Code)
        .ToListAsync();
    }

    public Task UpdateRangeAsync(IEnumerable<Category> categories)
    {
        _dbContext.Categories.UpdateRange(categories);
        return Task.CompletedTask;
    }
}
