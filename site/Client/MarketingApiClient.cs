namespace MarketingSite.Client;

public interface IMarketingApiClient
{
    Task<DateTime> GetCurrentDateTimeAsync();
}

public class MarketingApiClient(HttpClient httpClient) : IMarketingApiClient
{
    public async Task<DateTime> GetCurrentDateTimeAsync()
    {
        var response = await httpClient.GetAsync("/get");
        response.EnsureSuccessStatusCode();
        var dateTimeResponse = await response.Content.ReadFromJsonAsync<DateTimeResponse>();
        return dateTimeResponse?.CurrentDateTime ?? throw new InvalidOperationException("Invalid response from API");
    }

    private record DateTimeResponse(DateTime CurrentDateTime);
}