
using PFM.Application.Common.Interfaces;
using PFM.Application.Common.Models;
using System.Text.Json;

namespace PFM.Infrastructure.Services;

public class JsonAutoCategorizationRuleProvider : IAutoCategorizationRuleProvider
{
    private readonly string _filePath;

    public JsonAutoCategorizationRuleProvider()
    {
        _filePath = Path.Combine(AppContext.BaseDirectory, "Data",
            "auto-categorization-rules.json");
    }

    public async Task<List<AutoCategorizationRule>> GetRulesAsync()
    {
        if (!File.Exists(_filePath))
            return new List<AutoCategorizationRule>();

        var json = await File.ReadAllTextAsync(_filePath);

        var container = JsonSerializer.Deserialize<RuleContainer>(json, 
            new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true
        });

        return container?.Rules ?? new List<AutoCategorizationRule>();
    }

    private class RuleContainer
    {
        public List<AutoCategorizationRule> Rules { get; set; } = new();
    }
}