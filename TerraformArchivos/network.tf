
# --------------------------------------------------------------------------
# Autor: Giovanna Leon Granda / network.tf
# Descripción:
# Este archivo de Terraform define dos recursos de red en Azure:
# 1. **IP Pública Dinámica**: Crea una IP pública con asignación dinámica para la máquina virtual. 
#    La IP es de tipo "Básica" y está etiquetada como parte del entorno de producción.
# 2. **Interfaz de Red (NIC)**: Crea una interfaz de red para la máquina virtual. Esta interfaz se conecta 
#    a la red virtual de Azure, asignando tanto una dirección IP privada dinámica como una dirección IP pública dinámica.
#
# Estos recursos son fundamentales para proporcionar conectividad a la máquina virtual en la nube, permitiendo
# su acceso tanto desde redes privadas como públicas.
# --------------------------------------------------------------------------


# Crear la IP pública dinámica
resource "azurerm_public_ip" "dynamic_ip" {
  name                         = "myDynamicPublicIP"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  allocation_method            = "Dynamic"
  sku                          = "Basic"
  tags = {
    environment = "Production"
  }
}

# Crear la interfaz de red para la VM
resource "azurerm_network_interface" "nic" {
  name                = "myNIC"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "myIPConfig"
    subnet_id                    = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dynamic_ip.id
  }
}

