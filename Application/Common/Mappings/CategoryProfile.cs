using AutoMapper;
using PFM.Application.DTOs;
using PFM.Domain.Entities;

namespace PFM.Application.Common.Mappings;

public class CategoryProfile : Profile
{
    public CategoryProfile()
    {
        CreateMap<CategoryCsvDto, Category>()
            .ForMember(dest => dest.ParentCode,
                opt => opt.MapFrom(src =>
                    string.IsNullOrWhiteSpace(src.ParentCode) ? null : src.ParentCode));
        CreateMap<Category, CategoryCsvDto>()
            .ForMember(dest => dest.ParentCode, opt => opt.MapFrom(src => src.ParentCode ?? ""));
    }
}
