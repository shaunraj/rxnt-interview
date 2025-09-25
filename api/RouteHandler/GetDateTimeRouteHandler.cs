using MarketingApi.Services;

namespace MarketingApi.RouteHandler;

public record DateTimeResponse(DateTime CurrentDateTime);

public class GetDateTimeRouteHandler(IDateTimeService dateTimeService)
{
    public async Task<IResult> HandleRequest(HttpContext context, CancellationToken cancellationToken)
    {
        return Results.Ok(new DateTimeResponse(await dateTimeService.GetCurrent(cancellationToken)));
    }
}