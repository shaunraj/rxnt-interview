using MarketingSite;
using MarketingSite.RouteHandler;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddServices();

var app = builder.Build();

var helloWorldRouteHandler = app.Services.GetRequiredService<HelloWorldRouteHandler>();
var healthCheckRouteHandler = app.Services.GetRequiredService<HealthCheckRouteHandler>();

app.MapGet("/", helloWorldRouteHandler.HandleRequest);
app.MapGet("/health", healthCheckRouteHandler.HandleRequest);

app.Run();

public partial class Program
{
}