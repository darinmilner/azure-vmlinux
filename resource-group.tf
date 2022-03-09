resource "azurerm_resource_group" "myrg" {
  name     = "mtc-resources"
  location = "East Us"
  tags     = local.common-tags
}
