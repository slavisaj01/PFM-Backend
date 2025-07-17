
using AutoMapper;
using MediatR;
using PFM.Domain.Common;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Transactions.Queries.GetTransactions;

public class GetTransactionsQueryHandler : IRequestHandler<GetTransactionsQuery, GetTransactionsResponse>
{
    private readonly ITransactionRepository _repository;
    private readonly IMapper _mapper;

    public GetTransactionsQueryHandler(ITransactionRepository repository,IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<GetTransactionsResponse> Handle(GetTransactionsQuery request,
        CancellationToken cancellationToken)
    {
        var parameters = new TransactionQueryParams
        {
            PageNumber = request.PageNumber,
            PageSize = request.PageSize,
            SortBy = request.SortBy,
            SortOrder = request.SortOrder,
            TransactionKind = _mapper.Map<TransactionKind?>(request.TransactionKind),
            StartDate = _mapper.Map<DateTime?>(request.StartDate),
            EndDate = _mapper.Map<DateTime?>(request.EndDate),
        };

        PagedResult<Transaction> result = await _repository.GetTransactionsAsync(parameters);

        return new GetTransactionsResponse
        {
            Items = result.Items,
            TotalCount = result.TotalCount,
            Page = result.PageNumber,
            PageSize = result.PageSize,
            TotalPages = result.TotalPages,
            SortBy = request.SortBy,
            SortOrder = request.SortOrder
        };
    }
}

