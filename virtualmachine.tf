

# ---------------------------------------------------------------------------
# Autor: Giovanna Leon Granda / virtualmachine.tf
# Descripción:
# Este archivo de Terraform crea una máquina virtual (VM) en Azure con sistema operativo 
# Linux (Ubuntu 22.04 LTS) utilizando una imagen estándar proporcionada por Canonical. 
# La VM se configura con un disco de 30GB, se asigna un tamaño de máquina virtual 
# especificado a través de una variable, y se configura para la autenticación SSH 
# (deshabilitando la autenticación por contraseña).
# Los recursos asociados a la VM incluyen una interfaz de red y un disco de sistema 
# operativo.
#
# Requisitos previos:
# - Se debe tener un grupo de recursos ya creado en Azure.
# - La clave pública SSH debe estar disponible para configurar la autenticación.
# ---------------------------------------------------------------------------


# Crear la máquina virtual (VM) en Linux
resource "azurerm_virtual_machine" "vm" {
  name                  = "myLinuxVM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "myosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = 30
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_profile {
    computer_name  = "myLinuxVM"
    admin_username = var.vm_username
    admin_password = var.vm_password
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vm_username}/.ssh/authorized_keys"
      key_data = file("~/.ssh/id_rsa.pub")  # Cambia a la ruta de tu clave pública
    }
  }
}



#-------------------------------------------------------------------------- 
# Salidas
#--------------------------------------------------------------------------

output "public_ip" {
  value       = azurerm_public_ip.dynamic_ip.ip_address
  description = "La IP pública dinámica de la máquina virtual"
}

# Salidas para el ACR
output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

#-------------------------------------------------------------------------- 
# Locales
#--------------------------------------------------------------------------

locals {
  acr_name = "acr${replace(var.subscription_id, "-", "")}"  # Elimina los guiones
}
