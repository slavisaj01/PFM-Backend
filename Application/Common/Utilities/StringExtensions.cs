using System.Text.RegularExpressions;


namespace PFM.Application.Common.Utilities;

public static class StringExtensions
{
    public static string ToKebabCase(string input)
    {
        if (string.IsNullOrEmpty(input))
            return input;

        return Regex.Replace(input, "([a-z])([A-Z])", "$1-$2").ToLower();
    }
}

