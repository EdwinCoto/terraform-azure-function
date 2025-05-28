resource "azurerm_resource_group" "function_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "${var.function_name}storage"
  resource_group_name      = azurerm_resource_group.function_rg.name
  location                 = azurerm_resource_group.function_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "function_plan" {
  name                = "${var.function_name}-plan"
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name
  sku_name            = "Y1" # Dynamic SKU for Azure Functions
  os_type             = "windows"

}

resource "azurerm_windows_function_app" "function_app" {
  name                = var.function_name
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name


  service_plan_id            = azurerm_service_plan.function_plan.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  site_config {
    # Node.js version is managed by FUNCTIONS_EXTENSION_VERSION and FUNCTIONS_WORKER_RUNTIME
  }
  app_settings = {
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "FUNCTIONS_WORKER_RUNTIME"    = "node"
    //"WEBSITE_NODE_DEFAULT_VERSION" = "20" # Specify the Node.js version
    "AzureWebJobsStorage"         = azurerm_storage_account.function_storage.primary_connection_string
  }
}