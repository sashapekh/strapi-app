resource "azurerm_cosmosdb_postgresql_cluster" "db" {
  name                            = "stripedb"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  administrator_login_password    = "966JB4R6EQQfzWMxUAnh"
  coordinator_storage_quota_in_mb = 131072
  coordinator_vcore_count         = 2
  node_count                      = 0
  sql_version                     = 14
}
