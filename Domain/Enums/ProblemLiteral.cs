using System.Runtime.Serialization;

namespace PFM.Domain.Enums;

public enum ProblemLiteral
{
    [EnumMember(Value = "category-already-exists")]
    CategoryAlreadyExists,

    [EnumMember(Value = "category-in-use")]
    CategoryInUse,

    [EnumMember(Value = "split-amount-over-transaction-amount")]
    SplitAmountOverTransactionAmount,

    [EnumMember(Value = "provided-category-does-not-exists")]
    ProvidedCategoryDoesNotExists
}