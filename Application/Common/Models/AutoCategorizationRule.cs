
namespace PFM.Application.Common.Models;

public class AutoCategorizationRule
{
    public string Field { get; set; } = default!;
    public string Description { get; set; } = default!;
    public string Catcode { get; set; } = default!;
    public string Predicate { get; set; } = default!;
}

