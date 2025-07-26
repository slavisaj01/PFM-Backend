using AutoMapper;
using MediatR;
using PFM.Application.DTOs;
using PFM.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Application.UseCases.Categories.Queries.Get_Categories;

public class GetCategoriesQueryHandler : IRequestHandler<GetCategoriesQuery, List<CategoryCsvDto>>
{
    private readonly ICategoryRepository _categoryRepository;
    private readonly IMapper _mapper;

    public GetCategoriesQueryHandler(ICategoryRepository categoryRepository, IMapper mapper)
    {
        _categoryRepository = categoryRepository;
        _mapper = mapper;
    }

    public async Task<List<CategoryCsvDto>> Handle(GetCategoriesQuery request, CancellationToken cancellationToken)
    {
        var categories = await _categoryRepository.GetAllAsync(cancellationToken);

        return _mapper.Map<List<CategoryCsvDto>>(categories);
    }
}
