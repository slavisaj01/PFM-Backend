﻿using PFM.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Domain.Interfaces;

public interface ITransactionRepository
{
    Task AddAsync(Transaction transaction);
    Task AddRangeAsync(IEnumerable<Transaction> transactions);
}

