
using System.Text.Json.Serialization;

namespace PFM.Application.DTOs;

public class SpendingInCategoryDto
{
    [JsonPropertyName("cat-code")]
    public string Catcode { get; set; } = string.Empty;

    [JsonPropertyName("amount")]
    public double Amount { get; set; }

    [JsonPropertyName("count")]
    public int Count { get; set; }
}
