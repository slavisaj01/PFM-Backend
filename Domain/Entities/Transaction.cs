using PFM.Domain.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Domain.Entities;

public class Transaction
{
    public string Id { get; set; }

    public string? BeneficiaryName { get; set; }

    public DateTime Date { get; set; }

    public Direction Direction { get; set; }

    public decimal Amount { get; set; }

    public string? Description { get; set; }

    public string Currency { get; set; }

    public int? Mcc { get; set; }

    public TransactionKind Kind { get; set; }
}

