using PFM.Domain.Enums;

namespace PFM.Domain.Entities;

public class Transaction
{
    public string Id { get; set; }

    public string? BeneficiaryName { get; set; }

    public DateTime Date { get; set; }

    public Direction Direction { get; set; }

    public decimal Amount { get; set; }

    public string? Description { get; set; }

    public string Currency { get; set; }

    public MccCode? Mcc { get; set; }

    public TransactionKind Kind { get; set; }

    public string? CatCode { get; set; }  
    public Category? Category { get; set; }
    public ICollection<TransactionSplit> Splits { get; set; } = new List<TransactionSplit>();
}

