#--------------------------------------------------------------------------------------------------
# Autor: Giovanna Leon Granda / resources.tf
# Este archivo contiene la definición de recursos para la infraestructura en Azure utilizando Terraform.
# En este archivo se configuran los siguientes recursos:
# 1. Grupo de recursos en Azure (Resource Group)
# 2. Red Virtual (Virtual Network)
# 3. Subred (Subnet)
# 4. Azure Container Registry (ACR)
# 5. Clúster de Kubernetes (AKS)
# Estos recursos son fundamentales para el despliegue de aplicaciones en contenedores y en clústeres de Kubernetes sobre Azure.
#-----------------------------------------------------------------------------------------------

# Crear el grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Crear la red virtual
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Crear la subred
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Crear el Azure Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  sku                       = "Basic"
  admin_enabled             = true
}

# Crear el clúster de Kubernetes (AKS)
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.node_pool_size
  }

  identity {
    type = "SystemAssigned"
  }
}

