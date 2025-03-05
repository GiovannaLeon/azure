#-------------------------------------------------------------------------- 
# Autor: Giovanna Leon granda / maint.tf
# Este archivo configura Terraform para usar el proveedor de Azure (azurerm).
# Define la versión mínima de Terraform como 1.1.0 y especifica la versión 
# del proveedor de Azure (4.19.0 o compatible).
# Configura la conexión a Azure usando un subscription_id obtenido de una variable.
#--------------------------------------------------------------------------

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.19.0"
    }
  }

  required_version = ">= 1.1.0"
}

# Configuración de proveedores
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id  # Utilizamos la variable de la suscripción
}
