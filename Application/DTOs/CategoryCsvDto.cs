
using CsvHelper.Configuration.Attributes;

namespace PFM.Application.DTOs;

public class CategoryCsvDto
{
    [Name("code")]
    public string Code { get; set; }

    [Name("name")]
    public string Name { get; set; }

    [Name("parent-code")]
    public string? ParentCode { get; set; }
}
