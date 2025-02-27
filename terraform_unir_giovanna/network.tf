#--------------------------------------------------------------------------
# Autor: Giovanna Leon Granda
# Define los recursos de red, como la red virtual (azurerm_virtual_network), 
# la subred (azurerm_subnet) y la interfaz de red 
# (azurerm_network_interface).
#--------------------------------------------------------------------------

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

# Crear la interfaz de red para la VM
resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myIPConfig"
    subnet_id                    = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"  # IP privada dinámica
    public_ip_address_id          = azurerm_public_ip.dynamic_ip.id  # Asociamos la IP pública dinámica
  }
}