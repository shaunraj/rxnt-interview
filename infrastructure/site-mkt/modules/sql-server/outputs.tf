output "sql_server_connection_string" {
  value = azurerm_mssql_server.marketing_sql_server.fully_qualified_domain_name
}