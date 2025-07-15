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
        [BusinessProblemCodes.SplitAmountOverTransactionAmount] = (57452, "Split amount is larger than transaction amount")
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