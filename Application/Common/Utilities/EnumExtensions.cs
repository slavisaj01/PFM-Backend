using System.Reflection;
using System.Runtime.Serialization;

namespace PFM.Application.Common.Utilities;

public static class EnumExtensions
{
    public static string GetEnumMemberValue(this Enum enumValue)
    {
        var enumType = enumValue.GetType();
        var memberInfo = enumType.GetMember(enumValue.ToString()).FirstOrDefault();
        if (memberInfo != null)
        {
            var enumMemberAttr = memberInfo.GetCustomAttribute<EnumMemberAttribute>();
            if (enumMemberAttr != null)
                return enumMemberAttr.Value!;
        }
        return enumValue.ToString();
    }
}

