using System.ComponentModel.DataAnnotations;

namespace PFM.Application.DTOs;

public class BusinessProblemDto
{
    public required string Problem { get; set; }

    public required string Message { get; set; }

    public string? Details { get; set; }
}

