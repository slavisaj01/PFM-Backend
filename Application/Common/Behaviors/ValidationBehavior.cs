﻿using FluentValidation;
using MediatR;
using PFM.Application.Common.Exceptions;
using PFM.Application.Common.Helpers;
using PFM.Application.DTOs;
using static PFM.Application.Common.Utilities.StringExtensions;

namespace PFM.Application.Common.Behaviors;

public class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;

    public ValidationBehavior(IEnumerable<IValidator<TRequest>> validators)
    {
        _validators = validators;
    }
    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        if (_validators.Any())
        {
            var context = new ValidationContext<TRequest>(request);

            var validationResults = await Task.WhenAll(
                _validators.Select(v => v.ValidateAsync(context, cancellationToken)));

            var failures = validationResults
                .SelectMany(r => r.Errors)
                .Where(f => f != null)
                .ToList();

            if (failures.Count > 0)
            {
                var errorDto = new ValidationProblemDto
                {
                    Errors = failures.Select(error => new ValidationErrorDto
                    {
                        Tag = error.CustomState?.ToString() ?? ToKebabCase(error.PropertyName),
                        Error = ValidationErrorMapper.Map(error),
                        Message = error.ErrorMessage
                    }).ToList()
                };

                throw new ValidationProblemException(errorDto);
            }
        }

        return await next();
    }
}
