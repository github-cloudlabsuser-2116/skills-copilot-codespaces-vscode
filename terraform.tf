variable "storage_account_name" {
  description = "Name of the storage account to create. Must be unique across Azure."
  type        = string
  default     = "uniquestorageaccountname"
}

variable "location" {
  description = "Location for all resources."
  type        = string
  default     = "eastus" # This should ideally be dynamically set or passed as an input during runtime
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  properties = {
    supports_https_traffic_only = true
  }
}

output "storage_account_connection_string" {
  value = azurerm_storage_account.example.primary_connection_string
}