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
    always_on              = true
    ftps_state             = "AllAllowed"
    vnet_route_all_enabled = true
    application_stack {
      docker_image_name        = "stripeacr.azurecr.io/strapi:latest"
      docker_registry_username = var.docker_reg_user
      docker_registry_password = var.docker_reg_pass
    }
  }
  app_settings = {
    "HOST"                     = "0.0.0.0"
    "PORT"                     = "80"
    "APP_KEYS"                 = "mPZeXNnr+q4cs2dShOaBwg==,0JjeZCQ7oIQloB9QnnTPvQ==,5zmS/GNbMsYRzYVcQgtQOg==,nOmaJsZ/6d3Jm83K3HsK0A=="
    "API_TOKEN_SALT"           = "SBuWQIVBlibNLPr8YojKqA=="
    "ADMIN_JWT_SECRET"         = "ktQfxrQimDmoXZVjsAnsQA=="
    "TRANSFER_TOKEN_SALT"      = "owUmsQwFXRBjafRON1vIrw=="
    "JWT_SECRET"               = "YyWZOpXmh7tTkba33VPFYA=="
    "DATABASE_CLIENT"          = "postgres"
    "DATABASE_URL"             = local.postgre_connect_url
    "NODE_ENV"                 = "production"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }

  identity {
    type = "SystemAssigned"
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
