using CsvHelper.Configuration.Attributes;

namespace PFM.Application.DTOs;

public class TransactionCsvDto
{
    [Name("id")]
    public string Id { get; set; }

    [Name("beneficiary-name")]
    public string? BeneficiaryName { get; set; }

    [Name("date")]
    public DateTime Date { get; set; }

    [Name("direction")]
    public string Direction { get; set; }

    [Name("amount")]
    public double Amount { get; set; }

    [Name("description")]
    public string? Description { get; set; }

    [Name("currency")]
    public string Currency { get; set; }

    [Name("mcc")]
    public int? Mcc { get; set; }

    [Name("kind")]
    public string Kind { get; set; }
}

