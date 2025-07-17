using AutoMapper;

namespace PFM.Application.Common.Mappings;

public class DateTimeProfile : Profile
{
    public DateTimeProfile()
    {
        CreateMap<string, DateTime?>()
            .ConvertUsing(src => !string.IsNullOrWhiteSpace(src) ? DateTime.Parse(src) : null);
    }
}
