﻿using PFM.Domain.Common;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;
using PFM.Domain.Enums;

namespace PFM.Domain.Interfaces;

public interface ITransactionRepository
{
    Task AddRangeAsync(IEnumerable<Transaction> transactions);
    Task<PagedResult<Transaction>> GetTransactionsAsync(TransactionQueryParams query);
    Task<Transaction?> GetByIdAsync(string id, CancellationToken cancellationToken = default);
    Task<Category?> GetByCodeAsync(string code, CancellationToken cancellationToken = default);
    Task<List<Transaction>> GetTransactionsForAnalyticsAsync(
        string? catcode,
        DateTime? startDate,
        DateTime? endDate,
        Direction? direction
        );
    Task<List<Transaction>> GetUncategorizedAsync();
    void UpdateRange(IEnumerable<Transaction> transactions);
}

