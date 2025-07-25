
namespace PFM.Application.Common.Models;

public class AutoCategorizationRule
{
    public required string Field { get; set; } 
    public required string Description { get; set; } 
    public required string Catcode { get; set; } 
    public required string Predicate { get; set; }
}

