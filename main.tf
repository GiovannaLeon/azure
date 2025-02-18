terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}

  subscription_id = "d6dcc265-979b-4e5b-9cb5-a6ac0116f950"  # Reemplaza esto con tu ID de suscripción
}



# Crear un grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# Crear Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                     = "myacrregistry"  # Nombre único
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  sku                       = "Basic"
  admin_enabled            = true
}