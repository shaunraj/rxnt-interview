output "marketing_site_container_app_environment_id" {
  description = "The ID of the Container App Environment for the marketing site."
  value       = azurerm_container_app_environment.marketing_container_app_env.id
}