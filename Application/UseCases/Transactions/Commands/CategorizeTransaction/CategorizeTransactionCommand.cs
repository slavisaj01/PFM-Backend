using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Application.UseCases.Transactions.Commands.CategorizeTransaction;

public class CategorizeTransactionCommand : IRequest
{
    public string Id { get; set; }
    public string Catcode { get; set; }
}
