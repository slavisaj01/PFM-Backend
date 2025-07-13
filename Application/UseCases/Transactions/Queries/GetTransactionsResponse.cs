
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;
using System.Text.Json.Serialization;

namespace PFM.Application.UseCases.Transactions.Queries;

public class GetTransactionsResponse
{
    [JsonPropertyName("items")]
    public IEnumerable<Transaction> Items { get; set; } = [];

    [JsonPropertyName("total-count")]
    public int TotalCount { get; set; }

    [JsonPropertyName("page-size")]
    public int PageSize { get; set; }

    [JsonPropertyName("page")]
    public int Page { get; set; }

    [JsonPropertyName("total-pages")]
    public int TotalPages { get; set; }

    [JsonPropertyName("sort-order")]
    public string? SortOrder { get; set; }

    [JsonPropertyName("sort-by")]
    public string? SortBy { get; set; }
}

