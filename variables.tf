variable "function_name" {
  description = "The name of the Azure Function."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Azure Function will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}

variable "app_service_plan_id" {
  description = "The ID of the App Service Plan to use for the Azure Function."
  type        = string
}