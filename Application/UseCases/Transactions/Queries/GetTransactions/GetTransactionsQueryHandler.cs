
using AutoMapper;
using MediatR;
using PFM.Application.DTOs;
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
            SortBy = string.IsNullOrWhiteSpace(request.SortBy) ? "date" : request.SortBy,
            SortOrder = string.IsNullOrWhiteSpace(request.SortOrder) ? "desc" : request.SortOrder,
            TransactionKinds = _mapper.Map<List<TransactionKind>>(request.TransactionKinds),
            StartDate = _mapper.Map<DateTime?>(request.StartDate),
            EndDate = _mapper.Map<DateTime?>(request.EndDate),
        };

        PagedResult<Transaction> result = await _repository.GetTransactionsAsync(parameters);

        var dtoItems = _mapper.Map<IEnumerable<TransactionWithSplitsDto>>(result.Items);

        return new GetTransactionsResponse
        {
            Items = dtoItems,
            TotalCount = result.TotalCount,
            Page = result.PageNumber,
            PageSize = result.PageSize,
            TotalPages = result.TotalPages,
            SortBy = parameters.SortBy,
            SortOrder = parameters.SortOrder
        };
    }
}

