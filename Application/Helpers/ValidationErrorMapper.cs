
using FluentValidation.Results;

namespace PFM.Application.Helpers;

public class ValidationErrorMapper
{
    public static string Map(ValidationFailure failure)
    {
        var message = failure.ErrorMessage.ToLowerInvariant();

        if (message.Contains("direction must be 'd' or 'c'"))
            return "unknown-enum";

        if (message.Contains("invalid kind value"))
            return "unknown-enum";

        if (message.Contains("provided mcc is not valid"))
            return "not-on-list";

        if (failure.ErrorMessage.Contains("Invalid date format", StringComparison.OrdinalIgnoreCase))
            return "invalid-format";

        if (message.Contains("must be 3 characters or fewer") || 
                message.Contains("must be 3 characters or less"))
            return "max-length";

        if (message.Contains("must be at least 3 characters") || 
                message.Contains("must be 3 characters or more"))
            return "min-length";

        return failure.ErrorCode switch
        {
            "NotEmptyValidator" or "NotNullValidator" => "required",
            "GreaterThanValidator" or "LessThanValidator" => "out-of-range",
            "EnumValidator" => "unknown-enum",
            _ => "invalid-format"
        };
    }
}

