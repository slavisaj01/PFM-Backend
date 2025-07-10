using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

