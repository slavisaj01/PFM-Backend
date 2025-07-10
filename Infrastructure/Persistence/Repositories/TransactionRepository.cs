using Microsoft.EntityFrameworkCore;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using PFM.Infrastructure.Persistence.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

