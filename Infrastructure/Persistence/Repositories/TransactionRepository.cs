using Microsoft.EntityFrameworkCore;
using PFM.Domain.Entities;
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

    public async Task AddAsync(Transaction transaction)
    {
        _dbContext.Transactions.Add(transaction);
    }
    public async Task AddRangeAsync(IEnumerable<Transaction> transactions)
    {
        await _dbContext.Transactions.AddRangeAsync(transactions); 
    }

}

