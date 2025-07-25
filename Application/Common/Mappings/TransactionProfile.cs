using AutoMapper;
using PFM.Application.DTOs;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using System.Globalization;

namespace PFM.Application.Common.Mappings;

public class TransactionProfile : Profile
{
    public TransactionProfile()
    {
        CreateMap<Transaction, TransactionWithSplitsDto>();
        CreateMap<TransactionSplit, TransactionSplitDto>()
            .ForMember(dest => dest.Catcode, opt => opt.MapFrom(src => src.CategoryCode));

        CreateMap<TransactionCsvDto, Transaction>()
            .ForMember(dest => dest.Id, opt => opt.MapFrom(src => src.Id))
            .ForMember(dest => dest.BeneficiaryName, opt => opt.MapFrom(src => src.BeneficiaryName))
            .ForMember(dest => dest.Date, opt => opt.MapFrom(src =>
                DateTime.ParseExact(src.Date!, "M/d/yyyy", CultureInfo.InvariantCulture, 
                DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal)))
            .ForMember(dest => dest.Direction, opt => opt.MapFrom(src => 
            Enum.Parse<Direction>(src.Direction!, true)))
            .ForMember(dest => dest.Amount, opt => opt.MapFrom(src => (decimal)src.Amount!.Value))
            .ForMember(dest => dest.Description, opt => opt.MapFrom(src => src.Description))
            .ForMember(dest => dest.Currency, opt => opt.MapFrom(src => src.Currency))
            .ForMember(dest => dest.Mcc, opt => opt.MapFrom(src => src.Mcc))
            .ForMember(dest => dest.Kind, opt => opt.MapFrom(src => 
            Enum.Parse<TransactionKind>(src.Kind!, true)));

    }
}
