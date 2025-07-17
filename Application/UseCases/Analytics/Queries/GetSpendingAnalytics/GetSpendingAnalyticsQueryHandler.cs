using MediatR;
using PFM.Application.DTOs;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsQueryHandler : IRequestHandler<GetSpendingAnalyticsQuery,
        GetSpendingAnalyticsResponse>
{
    private readonly ITransactionRepository _repository;

    public GetSpendingAnalyticsQueryHandler(ITransactionRepository repository)
    {
        _repository = repository;
    }

    public async Task<GetSpendingAnalyticsResponse> Handle(GetSpendingAnalyticsQuery request, CancellationToken cancellationToken)
    {
        DateTime? startDate = !string.IsNullOrWhiteSpace(request.StartDate)
        ? DateTime.Parse(request.StartDate)
        : null;

        DateTime? endDate = !string.IsNullOrWhiteSpace(request.EndDate)
            ? DateTime.Parse(request.EndDate)
            : null;

        Direction? direction = request.Direction?.ToLower() switch
        {
            "d" => Direction.D,
            "c" => Direction.C,
            _ => null
        };
        //ovde ne koristim nesto kao TransactionQueryParams jer mi nije potrebno
        //nemam ni paginaciju niti sort niti enum neki sve su prosti parametri pa ih mogu poslati ovk
        var transactions = await _repository.GetTransactionsForAnalyticsAsync(
            request.Catcode,
            startDate,
            endDate,
            direction
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
