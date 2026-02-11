resource "azurerm_public_ip" "frontend_ip" {
  name                = "pip-marketing-frontend"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "marketing_vnet" {
  name                = local.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-marketing-appgw"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.marketing_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_application_gateway" "marketing_site" {
  name                = "agw-marketing-site-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ip-config"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "${local.frontend_port_name}-ssl"
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.frontend_ip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  ssl_certificate {
    name     = "appgw-ssl-cert"
    data     = var.pfx_certificate_data_base64
  }

  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "port-443"
    protocol                       = "Https"
    ssl_certificate_name           = "appgw-ssl-cert"
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "port-80"
    protocol                       = "Http"
  }

  redirect_configuration {
    name                 = "http-to-https-redirect"
    redirect_type        = "Permanent"
    target_listener_name = "https-listener"
    include_path         = true
    include_query_string = true
  }

  request_routing_rule {
    name                       = "https-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
  }

  request_routing_rule {
    name                        = "http-routing-rule"
    rule_type                   = "Basic"
    http_listener_name          = "http-listener"
    redirect_configuration_name = "http-to-https-redirect"
  }

  autoscale_configuration {
    min_capacity = 0
    max_capacity = 50
  }

}