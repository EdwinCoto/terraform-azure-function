resource "azurerm_resource_group" "function_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_app_service_plan" "function_plan" {
  name                = "${var.function_name}-plan"
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name
  sku {
    tier     = "Dynamic"
    size     = "Y1"
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = var.function_name
  location                   = azurerm_resource_group.function_rg.location
  resource_group_name        = azurerm_resource_group.function_rg.name
  app_service_plan_id        = azurerm_app_service_plan.function_plan.id
  storage_account_name       = "${var.function_name}storage"
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  version                    = "~3"
  os_type                    = "linux"
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "${var.function_name}storage"
  resource_group_name      = azurerm_resource_group.function_rg.name
  location                 = azurerm_resource_group.function_rg.location
  account_tier            = "Standard"
  account_replication_type = "LRS"
}