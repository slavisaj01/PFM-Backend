using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PFM.Application.Commands;

public class ImportTransactionsCommand : IRequest
{
    public Stream CsvStream { get; set; }
}

