//using AutoMapper;
//using PFM.Application.DTOs;
//using PFM.Domain.Entities;
//using PFM.Domain.Enums;

//namespace PFM.Application.Mapping;

//public class MappingProfile : Profile
//{
//    public MappingProfile()
//    {
//        CreateMap<TransactionCsvDto, Transaction>()
//            .ForMember(dest => dest.Direction,
//            opt => opt.MapFrom(src => Enum.Parse<Direction>(src.Direction, true)))
//            .ForMember(dest => dest.Kind,
//                opt => opt.MapFrom(src => Enum.Parse<TransactionKind>(src.Kind, true)))
//            .ForMember(dest => dest.Amount,
//                opt => opt.MapFrom(src => (decimal)src.Amount));
//    }
//}

