using PFM.Domain.Entities;

namespace PFM.Application.Common.Interfaces;

public interface ITransactionSplitRepository
{
    Task DeleteByTransactionIdAsync(string transactionId);
    Task AddRangeAsync(IEnumerable<TransactionSplit> splits);
}
