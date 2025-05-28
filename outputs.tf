output "function_endpoint" {
  value = azurerm_function_app.example.default_hostname
}

output "function_id" {
  value = azurerm_function_app.example.id
}