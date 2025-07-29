using AutoMapper;
using MediatR;
using PFM.Application.Common;
using PFM.Application.Common.Constants;
using PFM.Application.Common.Exceptions;
using PFM.Application.DTOs;
using PFM.Domain.Enums;
using PFM.Domain.Interfaces;

namespace PFM.Application.UseCases.Analytics.Queries.GetSpendingAnalytics;

public class GetSpendingAnalyticsQueryHandler : IRequestHandler<GetSpendingAnalyticsQuery,
        GetSpendingAnalyticsResponse>
{
    private readonly ITransactionRepository _transactionRepository;
    private readonly ICategoryRepository _categoryRepository;
    private readonly IMapper _mapper;

    public GetSpendingAnalyticsQueryHandler(ITransactionRepository repository, IMapper mapper,
          ICategoryRepository categoryRepository)
    {
        _transactionRepository = repository;
        _mapper = mapper;
        _categoryRepository = categoryRepository;
    }

    public async Task<GetSpendingAnalyticsResponse> Handle(GetSpendingAnalyticsQuery request, CancellationToken cancellationToken)
    {

        if (!string.IsNullOrWhiteSpace(request.Catcode))
        {
            var category = await _categoryRepository.GetByCodeAsync(request.Catcode);

            if (category is null)
            {
                throw BusinessProblemMessages.Create(
                    BusinessProblemCodes.ProvidedCategoryDoesNotExist,
                    $"Catcode with ID '{request.Catcode}' does not exist.");
            }
        }

        var transactions = await _transactionRepository.GetTransactionsForAnalyticsAsync(
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
