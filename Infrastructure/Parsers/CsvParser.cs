using CsvHelper;
using PFM.Application.Interfaces;
using System.Globalization;

namespace PFM.Infrastructure.Parsers;

public class CsvParser : ICsvParser
{
    public async Task<List<T>> ParseAsync<T>(Stream csvStream, CancellationToken cancellationToken)
    {
        using var reader = new StreamReader(csvStream, leaveOpen: true);
        using var csv = new CsvReader(reader, CultureInfo.InvariantCulture);

        var records = new List<T>();
        await foreach (var record in csv.GetRecordsAsync<T>(cancellationToken))
        {
            records.Add(record);
        }

        return records;
    }
}