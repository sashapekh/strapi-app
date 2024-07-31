
resource "azurerm_resource_group" "rg" {
  name     = "rg-strapi"
  location = var.location
}

resource "azurerm_service_plan" "sp" {
  name                = "stripesp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "B1"
}


resource "azurerm_linux_web_app" "app" {
  name                      = "strapiappsashapekh"
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  service_plan_id           = azurerm_service_plan.sp.id
  virtual_network_subnet_id = azurerm_subnet.subnet.id

  site_config {
    ftps_state             = "AllAllowed"
    vnet_route_all_enabled = true
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "stripesa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "stripesc"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
