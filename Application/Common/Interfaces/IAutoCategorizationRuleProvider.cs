using PFM.Application.Common.Models;

namespace PFM.Application.Common.Interfaces;

public interface IAutoCategorizationRuleProvider
{
    Task<List<AutoCategorizationRule>> GetRulesAsync();
}
