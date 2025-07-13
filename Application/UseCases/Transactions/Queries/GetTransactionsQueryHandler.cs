
using MediatR;
using PFM.Domain.Common;
using PFM.Domain.Common.Pagination;
using PFM.Domain.Entities;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Transactions.Queries;

public class GetTransactionsQueryHandler : IRequestHandler<GetTransactionsQuery, GetTransactionsResponse>
{
    private readonly ITransactionRepository _repository;

    public GetTransactionsQueryHandler(ITransactionRepository repository)
    {
        _repository = repository;
    }

    public async Task<GetTransactionsResponse> Handle(GetTransactionsQuery request,
        CancellationToken cancellationToken)
    {
        DateTime? startDate = !string.IsNullOrWhiteSpace(request.StartDate)
            ? DateTime.Parse(request.StartDate)
            : null;

        DateTime? endDate = !string.IsNullOrWhiteSpace(request.EndDate)
            ? DateTime.Parse(request.EndDate)
            : null;

        var parameters = new TransactionQueryParams
        {
            PageNumber = request.PageNumber,
            PageSize = request.PageSize,
            SortBy = request.SortBy,
            SortOrder = request.SortOrder,
            TransactionKind = request.TransactionKind,
            StartDate = startDate,
            EndDate = endDate
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

