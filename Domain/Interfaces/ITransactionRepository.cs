using PFM.Domain.Common;
using PFM.Domain.Entities;
using PFM.Domain.Common.Pagination;

namespace PFM.Domain.Interfaces;

public interface ITransactionRepository
{
    Task AddAsync(Transaction transaction);
    Task AddRangeAsync(IEnumerable<Transaction> transactions);
    Task<PagedResult<Transaction>> GetTransactionsAsync(TransactionQueryParams query);
}

