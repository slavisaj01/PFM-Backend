
namespace PFM.Application.DTOs;

public class ValidationProblemDto
{
    public List<ValidationErrorDto> Errors { get; set; } = new();
}

