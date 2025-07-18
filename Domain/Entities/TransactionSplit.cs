
namespace PFM.Domain.Entities;

public class TransactionSplit
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string TransactionId { get; set; } = default!;
    public string CategoryCode { get; set; } = default!;  

    public decimal Amount { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Utc);


    public Transaction? Transaction { get; set; }
    public Category? Category { get; set; }
}
