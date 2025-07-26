using System.Text.Json.Serialization;

namespace PFM.Application.DTOs;

public class TransactionCategorizeCommandDto
{
    [JsonPropertyName("cat-code")]
    public string? CatCode { get; set; }
}
