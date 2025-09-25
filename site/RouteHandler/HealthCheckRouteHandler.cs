namespace MarketingSite.RouteHandler;

public record HealthCheckResponse(string Status, string? Error = null);

public class HealthCheckRouteHandler
{
    public async Task<IResult> HandleRequest(HttpContext context, CancellationToken _)
    {
        return Results.Ok(
            await Task.FromResult(new HealthCheckResponse("healthy"))
        );
    }
}