﻿
namespace LoanManagement.Domain.Interfaces;

public interface IUnitOfWork
{
    Task SaveChangesAsync();
    Task SaveChangesAsync(CancellationToken cancellationToken);
}

