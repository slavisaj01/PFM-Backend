using System.Text.Json.Serialization;

namespace PFM.Application.DTOs;

public class TransactionWithSplitsDto
{
    [JsonPropertyName("id")]
    public string Id { get; set; } = default!;

    public string? BeneficiaryName { get; set; }

    [JsonPropertyName("date")]
    public DateTime Date { get; set; }

    [JsonPropertyName("direction")]
    public string Direction { get; set; } = default!;

    [JsonPropertyName("amount")]
    public double Amount { get; set; }

    [JsonPropertyName("description")]
    public string? Description { get; set; }

    [JsonPropertyName("currency")]
    public string Currency { get; set; } = default!;

    [JsonPropertyName("mcc")]
    public int? Mcc { get; set; }

    [JsonPropertyName("kind")]
    public string Kind { get; set; } = default!;

    [JsonPropertyName("cat-code")]
    public string? Catcode { get; set; }

    [JsonPropertyName("splits")]
    public List<TransactionSplitDto> Splits { get; set; } = new();
}
