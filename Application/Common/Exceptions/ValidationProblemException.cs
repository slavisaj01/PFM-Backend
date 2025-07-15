using PFM.Application.DTOs;

namespace PFM.Application.Common.Exceptions;

public class ValidationProblemException : Exception
{
    public ValidationProblemDto Validation { get; }

    public ValidationProblemException(ValidationProblemDto validation)
        : base("Validation failed")
    {
        Validation = validation;
    }
}

