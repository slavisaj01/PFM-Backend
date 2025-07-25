﻿
namespace PFM.Application.Common.Constants;

public static class BusinessProblemCodes
{
    public const string CategoryAlreadyExists = "category-already-exists";
    public const string CategoryInUse = "category-in-use";
    public const string ProvidedCategoryDoesNotExist = "provided-category-does-not-exists";
    public const string SplitAmountOverTransactionAmount = "split-amount-over-transaction-amount";
    public const string InvalidSplitCount = "invalid-split-count";
    public const string ProvidedTransactionDoesNotExist = "provided-transaction-does-not-exist";
    public const string CsvParsingError = "csv-parsing-error";
    public const string TransactionAlreadyExists = "transaction-already-exists";
    public const string InvalidCategorizationRule = "invalid-rule";
    public const string FailedToLoadCategorizationRules = "rule-loading-failed";
}
