using MediatR;
using PFM.Application.Common;
using PFM.Application.Common.Constants;
using PFM.Application.Common.Exceptions;
using PFM.Application.Common.Interfaces;
using PFM.Application.Common.Models;
using PFM.Domain.Entities;
using PFM.Domain.Interfaces;
using System.Linq.Dynamic.Core;
using System.Text;

namespace PFM.Application.UseCases.Transactions.Commands.AutoCategorizeTransactions;

public class AutoCategorizeTransactionsCommandHandler : IRequestHandler<AutoCategorizeTransactionsCommand>
{
    private readonly ITransactionRepository _transactionRepository;
    private readonly IAutoCategorizationRuleProvider _ruleProvider;
    private readonly IUnitOfWork _unitOfWork;

    public AutoCategorizeTransactionsCommandHandler(ITransactionRepository transactionRepository,
        IAutoCategorizationRuleProvider ruleProvider,
        IUnitOfWork unitOfWork)
    {
        _transactionRepository = transactionRepository;
        _ruleProvider = ruleProvider;
        _unitOfWork = unitOfWork;
    }

    public async Task Handle(AutoCategorizeTransactionsCommand request, CancellationToken cancellationToken)
    {
        List<AutoCategorizationRule> rules;

        try
        {
            rules = await _ruleProvider.GetRulesAsync();
        }
        catch (Exception)
        {
            throw BusinessProblemMessages.Create(
                BusinessProblemCodes.InvalidCategorizationRule,
                "Categorization rules could not be loaded. Please ensure the rule file is valid.");
        }

        var uncategorized = await _transactionRepository.GetUncategorizedAsync();


        foreach (var rule in rules)
        {
            List<Transaction> matching;

            try
            {
                matching = uncategorized
                    .AsQueryable()
                    .Where(rule.Predicate)
                    .ToList();
            }
            catch (Exception)
            {
                throw BusinessProblemMessages.Create(BusinessProblemCodes.InvalidCategorizationRule,
                    "Something went wrong while applying the rule. Please check that the rule is written correctly."
                    );
            }

            foreach (var transaction in matching)
            {
                if (transaction.CatCode is null)
                {
                    transaction.CatCode = rule.Catcode;
                }
            }
        }

        var categorizedTransactions = uncategorized.Where(t => t.CatCode != null).ToList();
        if (categorizedTransactions.Count != 0)
        {
            _transactionRepository.UpdateRange(categorizedTransactions);
        }

        await _unitOfWork.SaveChangesAsync();

        int total = uncategorized.Count;
        int categorized = uncategorized.Count(t => t.CatCode != null);
        int skipped = total - categorized;
        double successRate = total > 0 ? (double)categorized / total * 100 : 0;

        var logBuilder = new StringBuilder();
        var timestamp = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss");

        logBuilder.AppendLine($"=== Auto-categorization summary at {timestamp} ===");
        logBuilder.AppendLine($"Number of uncategorized transactions before auto-categorization: {total}");
        logBuilder.AppendLine($"Categorized: {categorized}");
        logBuilder.AppendLine($"Skipped (not matched): {skipped}");
        logBuilder.AppendLine($"Success rate: {successRate:F2}%");
        logBuilder.AppendLine("----------------------------------------------");
        logBuilder.AppendLine();

        await File.AppendAllTextAsync("logs/auto-categorization.txt", logBuilder.ToString());
    }
}
