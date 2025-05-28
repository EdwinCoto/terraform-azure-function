# Azure Function Terraform Module

This Terraform module creates an Azure Function along with the necessary resources such as an App Service Plan and a Resource Group.

## Prerequisites

- An Azure account with an active subscription.
- Terraform installed on your local machine.
- Azure CLI installed and configured.

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "azure_function" {
  source              = "./azure-function-module"
  function_name      = "your_function_name"
  resource_group_name = "your_resource_group_name"
  location           = "your_location"
}
```

## Input Variables

| Variable Name          | Description                          | Type   | Default Value |
|-----------------------|--------------------------------------|--------|---------------|
| `function_name`       | The name of the Azure Function       | string | n/a           |
| `resource_group_name` | The name of the Resource Group       | string | n/a           |
| `location`            | The Azure region to deploy resources  | string | "East US"     |

## Outputs

After applying the module, the following outputs will be available:

- `function_url`: The URL of the deployed Azure Function.
- `function_id`: The resource ID of the Azure Function.

## Example

Here is a complete example of how to use this module:

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}

module "azure_function" {
  source              = "./azure-function-module"
  function_name      = "exampleFunction"
  resource_group_name = azurerm_resource_group.example.name
  location           = azurerm_resource_group.example.location
}
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.