
namespace PFM.Domain.Entities;

public class TransactionSplit
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required string TransactionId { get; set; } 
    public required string CategoryCode { get; set; }   

    public decimal Amount { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;


    public Transaction? Transaction { get; set; }
    public Category? Category { get; set; }
}
