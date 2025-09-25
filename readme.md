# Hello World Site

This site is the first version of the Hello World Site. It is composed of two projects `Site` and `Api`.

## Requirements to run the site

The Site container expects the following environment variables:
- `REDIS_CONNECTION_STRING` to contain a connection string for a Redis server.
- `MarketingApi__BaseUrl` to contain the base URL of the Api project.

The Api container expects the following environment variables:
- `DB_CONNECTION_STRING` to contain a connection string for a SQL Server.

The solution also contains a `docker-compose.yml` file that can be used to run the site locally using Docker.