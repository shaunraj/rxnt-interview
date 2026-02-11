locals {
  vnet_name                      = "vnet-marketing"
  backend_address_pool_name      = "${local.vnet_name}-beap"
  frontend_port_name             = "${local.vnet_name}-feport"
  frontend_ip_configuration_name = "${local.vnet_name}-feip"
  http_setting_name              = "${local.vnet_name}-be-htst"
  listener_name                  = "${local.vnet_name}-httplstn"
  request_routing_rule_name      = "${local.vnet_name}-rqrt"
  redirect_configuration_name    = "${local.vnet_name}-rdrcfg"
}
