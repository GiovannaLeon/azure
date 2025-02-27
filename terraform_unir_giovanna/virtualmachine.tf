#--------------------------------------------------------------------------
# Autor: Giovanna Leon Granda
# Define los recursos relacionados con la máquina virtual, 
# como la máquina virtual Linux (azurerm_virtual_machine), 
# y si es necesario, el clúster de Kubernetes (azurerm_kubernetes_cluster).
#--------------------------------------------------------------------------


#--------------------------------------------------------------------------
#Autor: Giovanna Leon Granda
#Define los recursos relacionados con la máquina virtual, 
#como la máquina virtual Linux (azurerm_virtual_machine), 
#y si es necesario, el clúster de Kubernetes (azurerm_kubernetes_cluster).
#--------------------------------------------------------------------------

# Crear la máquina virtual (VM) en Linux
resource "azurerm_virtual_machine" "vm" {
  name                  = "myLinuxVM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"  # Tamaño de la VM

  storage_os_disk {
    name              = "myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = 30
  }

  storage_image_reference {
publisher = "Canonical"
offer = "0001-com-ubuntu-server-jammy"
sku = "22_04-lts"
version = "latest"
  }

  os_profile {
    computer_name  = "myLinuxVM"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
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

