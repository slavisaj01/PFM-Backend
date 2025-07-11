﻿
namespace PFM.Application.Exceptions;

public class BusinessException : Exception
{
    public string Problem { get; }
    public string? Details { get; }

    public BusinessException(string problem, string message, string? details = null)
            : base(message)
    {
        Problem = problem;
        Details = details;
    }
}

