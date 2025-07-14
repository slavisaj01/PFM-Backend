
using MediatR;

namespace PFM.Application.UseCases.Categories.Commands;

public class ImportCategoriesCommand : IRequest
{
    public Stream CsvStream { get; set; }
}

