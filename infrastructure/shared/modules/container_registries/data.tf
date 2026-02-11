data "azuread_group" "azure_ad_groups" {
  for_each     = { for role in local.role_assignments : role.ad_group_name => role }
  display_name = each.value.ad_group_name
}