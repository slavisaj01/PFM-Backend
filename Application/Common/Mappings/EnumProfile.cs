
using AutoMapper;
using PFM.Domain.Enums;

namespace PFM.Application.Common.Mappings;

public class EnumProfile : Profile
{
    public EnumProfile()
    {
        CreateMap<string, TransactionKind?>()
            .ConvertUsing(src => ConvertToTransactionKind(src));

        CreateMap<string, Direction?>()
            .ConvertUsing(src => ConvertToDirection(src));
    }

    private static TransactionKind? ConvertToTransactionKind(string? value)
    {
        if (string.IsNullOrWhiteSpace(value)) return null;

        return value.ToLower() switch
        {
            "dep" => TransactionKind.Dep,
            "wdw" => TransactionKind.Wdw,
            "pmt" => TransactionKind.Pmt,
            "fee" => TransactionKind.Fee,
            "inc" => TransactionKind.Inc,
            "rev" => TransactionKind.Rev,
            "adj" => TransactionKind.Adj,
            "lnd" => TransactionKind.Lnd,
            "lnr" => TransactionKind.Lnr,
            "fcx" => TransactionKind.Fcx,
            "aop" => TransactionKind.Aop,
            "acl" => TransactionKind.Acl,
            "spl" => TransactionKind.Spl,
            "sal" => TransactionKind.Sal,
            _ => null
        };
    }

    private static Direction? ConvertToDirection(string? value)
    {
        if (string.IsNullOrWhiteSpace(value)) return null;

        return value.ToLower() switch
        {
            "d" => Direction.D,
            "c" => Direction.C,
            _ => null
        };
    }
}