using MediatR;
using PFM.Application.DTOs;

namespace PFM.Application.UseCases.Categories.Queries.Get_Categories;

public class GetCategoriesQuery : IRequest<List<CategoryCsvDto>>
{
}
