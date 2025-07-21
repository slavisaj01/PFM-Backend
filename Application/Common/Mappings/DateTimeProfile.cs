using AutoMapper;
using System.Globalization;

namespace PFM.Application.Common.Mappings;

public class DateTimeProfile : Profile
{
    public DateTimeProfile()
    {
        CreateMap<string, DateTime?>()
            .ConvertUsing(src =>
                !string.IsNullOrWhiteSpace(src)
                ? DateTime.SpecifyKind(DateTime.Parse(src, CultureInfo.InvariantCulture), DateTimeKind.Utc)
                : null);
    }
}
