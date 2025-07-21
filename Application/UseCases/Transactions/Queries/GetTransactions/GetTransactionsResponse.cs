using PFM.Application.DTOs;
using System.Text.Json.Serialization;

namespace PFM.Application.UseCases.Transactions.Queries.GetTransactions;

public class GetTransactionsResponse
{
    [JsonPropertyName("items")]
    public IEnumerable<TransactionWithSplitsDto> Items { get; set; } = [];

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

