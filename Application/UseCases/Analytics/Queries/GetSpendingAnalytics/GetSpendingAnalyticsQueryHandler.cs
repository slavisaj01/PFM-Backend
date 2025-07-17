using AutoMapper;
using MediatR;
using PFM.Application.DTOs;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsQueryHandler : IRequestHandler<GetSpendingAnalyticsQuery,
        GetSpendingAnalyticsResponse>
{
    private readonly ITransactionRepository _repository;
    private readonly IMapper _mapper;

    public GetSpendingAnalyticsQueryHandler(ITransactionRepository repository, IMapper mapper)
    {
        _repository = repository;
        _mapper = mapper;
    }

    public async Task<GetSpendingAnalyticsResponse> Handle(GetSpendingAnalyticsQuery request, CancellationToken cancellationToken)
    {
        //ovde ne koristim nesto kao TransactionQueryParams jer mi nije potrebno
        //nemam ni paginaciju niti sort niti enum neki sve su prosti parametri pa ih mogu poslati ovk
        var transactions = await _repository.GetTransactionsForAnalyticsAsync(
            request.Catcode,
            _mapper.Map<DateTime?>(request.StartDate),
            _mapper.Map<DateTime?>(request.EndDate),
            _mapper.Map<Direction?>(request.Direction)
        );

        var grouped = transactions
            .GroupBy(t => t.CatCode)
            .Select(g => new SpendingInCategoryDto
            {
                Catcode = g.Key!,
                Amount = Math.Round((double)g.Sum(t => t.Amount), 2),
                Count = g.Count()
            })
            .ToList();

        return new GetSpendingAnalyticsResponse
        {
            Groups = grouped
        };

    }
}
