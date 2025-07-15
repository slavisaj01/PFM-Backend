using PFM.Domain.Entities;
using PFM.Domain.Interfaces;

namespace PFM.Domain.Common.Services;

public class CategoryDomainService : ICategoryDomainService
{
    public bool IsDuplicateCode(string code, IEnumerable<Category> existingCategories)
    {
        return existingCategories.Any(c => c.Code.Equals(code, StringComparison.OrdinalIgnoreCase));
    }
}
