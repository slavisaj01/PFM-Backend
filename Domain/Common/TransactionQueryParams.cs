using PFM.Domain.Common.Pagination;
using PFM.Domain.Enums;

namespace PFM.Domain.Common;

public class TransactionQueryParams : PaginationParams
{
    public TransactionKind? TransactionKind { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? EndDate { get; set; }

    public string? SortBy { get; set; }
    public string? SortOrder { get; set; } = "asc";

}

