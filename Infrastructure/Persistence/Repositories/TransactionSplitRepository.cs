using Microsoft.EntityFrameworkCore;
using PFM.Application.Common.Interfaces;
using PFM.Domain.Entities;
using PFM.Infrastructure.Persistence.Data;

namespace PFM.Infrastructure.Persistence.Repositories;

public class TransactionSplitRepository : ITransactionSplitRepository
{
    private readonly ApplicationDbContext _context;

    public TransactionSplitRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task AddRangeAsync(IEnumerable<TransactionSplit> splits)
    {
        await _context.TransactionSplits.AddRangeAsync(splits);
    }

    public async Task DeleteByTransactionIdAsync(string transactionId)
    {
        var existingSplits = await _context.TransactionSplits
           .Where(s => s.TransactionId == transactionId)
           .ToListAsync();

        _context.TransactionSplits.RemoveRange(existingSplits);
    }
}
