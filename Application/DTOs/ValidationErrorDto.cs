
namespace PFM.Application.DTOs;

public class ValidationErrorDto
{
    public required string Tag { get; set; }
    public required string Error { get; set; }
    public required string Message { get; set; }
}

