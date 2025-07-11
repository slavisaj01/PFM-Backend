using PFM.Domain.Entities;

namespace PFM.Domain.Interfaces;

public interface ITransactionRepository
{
    Task AddAsync(Transaction transaction);
    Task AddRangeAsync(IEnumerable<Transaction> transactions);
}

