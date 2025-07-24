using Microsoft.EntityFrameworkCore;
using PFM.Domain.Common;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Persistence.Data;

namespace PFM.Infrastructure.Persistence.Repositories;

public class TransactionRepository : ITransactionRepository
{
    private readonly ApplicationDbContext _dbContext;

    public TransactionRepository(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task AddRangeAsync(IEnumerable<Transaction> transactions)
    {
        await _dbContext.Transactions.AddRangeAsync(transactions);
    }

    public async Task<PagedResult<Transaction>> GetTransactionsAsync(TransactionQueryParams query)
    {
        var transactions = _dbContext.Transactions
            .Include(t => t.Splits)
            .AsQueryable();

        if (query.TransactionKinds is { Count: > 0 })
        {
            transactions = transactions.Where(t => query.TransactionKinds.Contains(t.Kind));
        }

        if (query.StartDate.HasValue)
        {
            transactions = transactions.Where(t => t.Date >= query.StartDate.Value);
        }

        if (query.EndDate.HasValue)
        {
            transactions = transactions.Where(t => t.Date <= query.EndDate.Value);
        }

        var sortBy = query.SortBy?.ToLower() ?? "date";
        var sortOrder = query.SortOrder?.ToLower() == "desc" ? "desc" : "asc";

        transactions = (sortBy, sortOrder) switch
        {
            ("amount", "desc") => transactions.OrderByDescending(t => t.Amount),
            ("amount", "asc") => transactions.OrderBy(t => t.Amount),

            ("beneficiary-name", "desc") => transactions.OrderByDescending(t => t.BeneficiaryName),
            ("beneficiary-name", "asc") => transactions.OrderBy(t => t.BeneficiaryName),

            ("date", "desc") => transactions.OrderByDescending(t => t.Date),
            (_, _) => transactions.OrderBy(t => t.Date)
        };

        var totalCount = await transactions.CountAsync();

        var items = await transactions
            .Skip((query.PageNumber - 1) * query.PageSize)
            .Take(query.PageSize)
            .ToListAsync();

        return new PagedResult<Transaction>(items, totalCount, query.PageNumber, query.PageSize);
    }

    public async Task<Transaction?> GetByIdAsync(string id, CancellationToken cancellationToken = default)
    {
        return await _dbContext.Transactions.FirstOrDefaultAsync(t =>
            t.Id == id, cancellationToken);
    }

    public async Task<Category?> GetByCodeAsync(string code, CancellationToken cancellationToken = default)
    {
        return await _dbContext.Categories.FirstOrDefaultAsync(c => c.Code == code, cancellationToken);
    }

    public async Task<List<Transaction>> GetTransactionsForAnalyticsAsync(string? catcode, 
        DateTime? startDate, DateTime? endDate, Direction? direction)
    {
        var query = _dbContext.Transactions.AsQueryable();

        if (!string.IsNullOrWhiteSpace(catcode))
            query = query.Where(t => t.CatCode == catcode);

        if (startDate.HasValue)
            query = query.Where(t => t.Date >= startDate.Value);

        if (endDate.HasValue)
            query = query.Where(t => t.Date <= endDate.Value);

        if (direction.HasValue)
            query = query.Where(t => t.Direction == direction.Value);

        return await query.ToListAsync();
    }

    public async Task<List<Transaction>> GetUncategorizedAsync()
    {
        return await _dbContext.Transactions
            .Where(t => t.CatCode == null)
            .ToListAsync();
    }

    public void UpdateRange(IEnumerable<Transaction> transactions)
    {
        _dbContext.Transactions.UpdateRange(transactions);
    }

}

