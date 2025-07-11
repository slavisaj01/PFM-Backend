
using FluentValidation.Results;

namespace PFM.Application.Helpers;

public class ValidationErrorMapper
{
    public static string Map(ValidationFailure failure)
    {
        if (failure.ErrorMessage.Contains("Direction must be 'd' or 'c'", StringComparison.OrdinalIgnoreCase))
            return "unknown-enum";

        if (failure.ErrorMessage.Contains("Invalid Kind value", StringComparison.OrdinalIgnoreCase))
            return "unknown-enum";

        if (failure.ErrorMessage.Contains("Provided MCC is not valid", StringComparison.OrdinalIgnoreCase))
            return "not-on-list";

        if (failure.ErrorCode == "LengthValidator" &&
                failure.FormattedMessagePlaceholderValues != null)
        {
            if (failure.FormattedMessagePlaceholderValues.ContainsKey("MinLength"))
                return "min-length";

            if (failure.FormattedMessagePlaceholderValues.ContainsKey("MaxLength"))
                return "max-length";

            return "length"; 
        }

        return failure.ErrorCode switch
        {
            "NotEmptyValidator" or "NotNullValidator" => "required",
            "GreaterThanValidator" or "LessThanValidator" => "out-of-range",
            "EnumValidator" => "unknown-enum",
            _ => "invalid-format"
        };
    }
}

