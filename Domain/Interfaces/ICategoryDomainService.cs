using PFM.Domain.Entities;

namespace PFM.Domain.Interfaces;

public interface ICategoryDomainService
{
    bool IsDuplicateCode(string code, IEnumerable<Category> existingCategories);
}
