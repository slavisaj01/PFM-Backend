﻿
namespace PFM.Application.Common.Interfaces;

public interface IUnitOfWork
{
    Task SaveChangesAsync();
}

