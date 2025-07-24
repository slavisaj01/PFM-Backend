using PFM.Application.Common.Constants;
using PFM.Application.Common.Exceptions;

namespace PFM.Application.Common;

public static class BusinessProblemMessages
{
    public static readonly Dictionary<string, (int Code, string Message)> Map = new()
    {
        [BusinessProblemCodes.CategoryAlreadyExists] = (57450, "Category already exists"),
        [BusinessProblemCodes.CategoryInUse] = (57451, "Cannot delete category as it is in use"),
        [BusinessProblemCodes.ProvidedCategoryDoesNotExist] = (47453, "Provided category does not exist"),
        [BusinessProblemCodes.SplitAmountOverTransactionAmount] = (57452, "Split amount is larger than transaction amount"),
        [BusinessProblemCodes.InvalidSplitCount] = (57454, "Invalid number of splits"),
        [BusinessProblemCodes.ProvidedTransactionDoesNotExist] = (47455, "Provided transaction does not exist"),
        [BusinessProblemCodes.CsvParsingError] = (47456, "CSV file could not be parsed. The format or structure is invalid."),
        [BusinessProblemCodes.TransactionAlreadyExists] = (57456, "Transaction already exists"),
        [BusinessProblemCodes.InvalidCategorizationRule] = (47457, "Invalid auto-categorization rule"),
        [BusinessProblemCodes.FailedToLoadCategorizationRules] = (47458, "Categorization rules could not be loaded from the configuration file")

    };

    public static BusinessException Create(string problemCode, string? details = null)
    {
        if (Map.TryGetValue(problemCode, out var info))
        {
            return new BusinessException(problemCode, info.Message, details);
        }

        throw new ArgumentException($"Unknown problem code: {problemCode}");
    }

}