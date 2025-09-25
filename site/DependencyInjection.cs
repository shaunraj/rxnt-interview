using MarketingSite.Client;
using MarketingSite.RouteHandler;
using MarketingSite.Services;

namespace MarketingSite;

public static class DependencyInjection
{
    public static void AddServices(this IServiceCollection services)
    {
        services.AddSingleton<IHtmlTemplateGenerator, HtmlTemplateGenerator>();
        services.AddSingleton<IHelloWorldService, HelloWorldService>();
        services.AddSingleton<ICacheService, CacheService>();
        services.AddRouteHandlers();
        services.AddMarketingApiClient();
    }

    private static void AddRouteHandlers(this IServiceCollection services)
    {
        services.AddSingleton<HelloWorldRouteHandler>();
        services.AddSingleton<HealthCheckRouteHandler>();
    }

    private static void AddMarketingApiClient(this IServiceCollection services)
    {
        services.AddHttpClient<IMarketingApiClient, MarketingApiClient>((context, client) =>
        {
            var configuration = context.GetRequiredService<IConfiguration>();
            client.BaseAddress = new Uri(configuration["MarketingApi:BaseUrl"] ??
                                         throw new InvalidOperationException("MarketingApi:BaseUrl is not configured"));
        });
    }
}