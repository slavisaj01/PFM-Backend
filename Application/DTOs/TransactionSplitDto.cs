
using System.Text.Json.Serialization;

namespace PFM.Application.DTOs;

public class TransactionSplitDto
{
    [JsonPropertyName("cat-code")]
    public string? Catcode { get; set; }

    [JsonPropertyName("amount")]
    public double Amount { get; set; }
}
