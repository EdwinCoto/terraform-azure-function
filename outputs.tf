output "function_endpoint" {
  value = azurerm_windows_function_app.function_app.default_hostname
}

output "function_id" {
  value = azurerm_windows_function_app.function_app.id
}