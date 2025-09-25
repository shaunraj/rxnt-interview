using MarketingSite.Services;

namespace MarketingSite.RouteHandler;

public class HelloWorldRouteHandler(IHelloWorldService helloWorldService)
{
    public async Task HandleRequest(HttpContext context)
    {
        context.Response.ContentType = "text/html";
        await context.Response.WriteAsync(await helloWorldService.GenerateHtmlContent());
    }
}