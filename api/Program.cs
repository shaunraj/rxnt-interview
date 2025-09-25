using MarketingApi;
using MarketingApi.RouteHandler;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddServices();

var app = builder.Build();

var helloWorldRouteHandler = app.Services.GetRequiredService<GetDateTimeRouteHandler>();
var healthCheckRouteHandler = app.Services.GetRequiredService<HealthCheckRouteHandler>();

app.MapGet("/get", helloWorldRouteHandler.HandleRequest)
    .WithName("GetDateTime")
    .WithTags("DateTime");
app.MapGet("/health", healthCheckRouteHandler.HandleRequest)
    .WithName("HealthCheck")
    .WithTags("Health");

app.Run();

public partial class Program
{
}