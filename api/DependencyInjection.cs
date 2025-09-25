using MarketingApi.RouteHandler;
using MarketingApi.Services;

namespace MarketingApi;

public static class DependencyInjection
{
    public static void AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IDateTimeService, DateTimeService>();
        services.AddRouteHandlers();
    }

    private static void AddRouteHandlers(this IServiceCollection services)
    {
        services.AddSingleton<GetDateTimeRouteHandler>();
        services.AddSingleton<HealthCheckRouteHandler>();
    }
}