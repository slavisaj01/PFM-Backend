
using MediatR;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Enums;

namespace PFM.Application.UseCases.Transactions.Queries;

public class GetTransactionsQuery : PaginationParams,IRequest<GetTransactionsResponse>
{
    public string? SortBy { get; set; }
    public string? SortOrder { get; set; }
    public TransactionKind? TransactionKind { get; set; }
    public string? StartDate { get; set; }
    public string? EndDate { get; set; }
}

