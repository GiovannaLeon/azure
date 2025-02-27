#--------------------------------------------------------------------------
# Autor: Giovanna Leon Granda
# Define los recursos principales, como el grupo de recursos (azurerm_resource_group) 
# y la IP pública dinámica (azurerm_public_ip). Además, 
# incluye salidas que te permitan obtener información de los recursos creados, como la dirección IP pública.
#--------------------------------------------------------------------------

# Crear el grupo de recursos
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Crear la IP pública dinámica
resource "azurerm_public_ip" "dynamic_ip" {
  name                         = "myDynamicPublicIP"   # Nombre de la IP pública
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  allocation_method            = "Dynamic"              # Ahora la IP será dinámica
  sku                          = "Basic"               # Puede ser Basic o Standard
  tags = {
    environment = "Production"
  }
}

# Salida de la IP pública dinámica
output "public_ip" {
  value       = azurerm_public_ip.dynamic_ip.ip_address
  description = "La IP pública dinámica de la máquina virtual"
}
