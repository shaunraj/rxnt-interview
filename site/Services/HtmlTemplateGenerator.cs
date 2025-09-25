namespace MarketingSite.Services;

public interface IHtmlTemplateGenerator
{
    string GenerateHelloWorld(string title, string body);
}

public class HtmlTemplateGenerator : IHtmlTemplateGenerator
{
    public string GenerateHelloWorld(string title, string body)
    {
        return
            @$"
        <html>
            <head>
                <meta charset='UTF-8'>
                <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                <meta http-equiv='refresh' content='1'>
                <style>
            * {{
                font-family: 'Segoe UI', Roboto, Arial, sans-serif; 
                box-sizing: border-box; 
                margin: 0; 
                padding: 0; 
            }}

            body {{
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: linear-gradient(135deg, #74ABE2, #5563DE);
                color: #fff;
                text-align: center;
            }}

            h1 {{
                font-size: 3rem;
                font-weight: 700;
                margin-bottom: 1rem;
                text-shadow: 2px 2px 6px rgba(0,0,0,0.3);
            }}

            p {{
                font-size: 1.2rem;
                background: rgba(255,255,255,0.15);
                padding: 0.8rem 1.2rem;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
                backdrop-filter: blur(5px);
                max-width: 80%;
            }}

            code {{
                font-family: 'Fira Code', Consolas, monospace;
                background: rgba(0, 0, 0, 0.7);
                color: #ffecb3;
                padding: 0.2rem 0.4rem;
                border-radius: 6px;
                box-shadow: inset 0 0 6px rgba(0,0,0,0.4);
                font-size: 0.95rem;
            }}
                </style>
                <title>{title}</title>
            </head>
            <body>{body}</body>
        </html>
        ";
    }
}