using Microsoft.Data.SqlClient;

namespace MarketingApi.Services;

public interface IDateTimeService
{
    Task<DateTime> GetCurrent(CancellationToken cancellationToken);
}

public class DateTimeService(IConfiguration configuration) : IDateTimeService
{
    public async Task<DateTime> GetCurrent(CancellationToken cancellationToken)
    {
        await using var connection = new SqlConnection(configuration["DB_CONNECTION_STRING"]);
        await connection.OpenAsync(cancellationToken);

        const string sql = "SELECT GETDATE() AS CurrentDateTime";
        await using var command = new SqlCommand(sql, connection);
        var result = await command.ExecuteScalarAsync(cancellationToken);
        if (result is DateTime dateTime) return dateTime;

        throw new Exception("Unable to retrieve current date and time.")
        {
            Data =
            {
                ["SqlResultType"] = result?.GetType().FullName ?? "null",
                ["result"] = result?.ToString() ?? "null"
            }
        };
    }
}