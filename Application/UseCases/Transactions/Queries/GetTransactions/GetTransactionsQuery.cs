
using MediatR;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Enums;

namespace PFM.Application.UseCases.Transactions.Queries.GetTransactions;

public class GetTransactionsQuery : PaginationParams,IRequest<GetTransactionsResponse>
{
    public string? SortBy { get; set; }
    public string? SortOrder { get; set; }
    public List<string>? TransactionKinds { get; set; }
    public string? StartDate { get; set; }
    public string? EndDate { get; set; }
}

