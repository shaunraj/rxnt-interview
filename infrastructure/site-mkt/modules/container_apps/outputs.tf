output "frontend_managed_identity" {
    value = azurerm_container_app.frontend.identity[0].principal_id
}
  
output "backend_managed_identity" {
    value = azurerm_container_app.backend.identity[0].principal_id
}