
using MediatR;

namespace PFM.Application.UseCases.Categories.Commands.ImportCategories;

public class ImportCategoriesCommand : IRequest
{
    public Stream CsvStream { get; set; }
}

