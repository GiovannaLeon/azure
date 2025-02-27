#--------------------------------------------------------------------------
# Autor: Giovanna Leon Granda
# Contiene la configuración de Terraform: Proveedor y version
# Aquí se define el proveedor de Azure (azurerm) y cualquier otra configuración global, en este caso el id de la subscripción
# Este fichero hace uso del fichero var.tf
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