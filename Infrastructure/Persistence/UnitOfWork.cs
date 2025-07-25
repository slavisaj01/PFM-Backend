﻿using PFM.Application.Common.Interfaces;
using PFM.Infrastructure.Persistence.Data;

namespace PFM.Infrastructure.Persistence.Repositories;

public class UnitOfWork : IUnitOfWork
{
    private readonly ApplicationDbContext _context;

    public UnitOfWork(ApplicationDbContext context)
    {
        _context = context;

    }

    public async Task SaveChangesAsync()
    {
        await _context.SaveChangesAsync();
    }
}

