#--------------------------------------------------------------------------  
# Autor: Giovanna Leon Granda 
# Define las variables que se utilizarán en los otros archivos.
#----------------------------------------------------------------------

variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
  default     = "d6dcc265-979b-4e5b-9cb5-a6ac0116f950"  # Reemplázalo con tu ID de suscripción
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  default     = "myResourceGroup"
}

variable "location" {
  type        = string
  description = "Azure region where infrastructure will be created"
  default     = "Spain Central"
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_D1_v2"
}

variable "vnet_name" {
  description = "Nombre de la red virtual"
  default     = "myVNet"
}

variable "subnet_name" {
  description = "Nombre de la subred"
  default     = "mySubnet"
}

variable "vm_username" {
  description = "Nombre de usuario para la máquina virtual"
  default     = "ubuntu_user"
}

variable "vm_password" {
  description = "Contraseña para la máquina virtual"
  type        = string
  default     = "MiContrasenaSegura123!"
  sensitive   = true
}

variable "aks_name" {
  description = "Nombre del clúster de Kubernetes"
  default     = "myAKSCluster"
}

variable "node_pool_size" {
  description = "Tamaño de los nodos en el clúster de AKS"
  default     = "Standard_B2s"
}

variable "acr_name" {
  description = "Nombre del Azure Container Registry"
  type        = string
  default     = "myacr01"  # Nombre básico por defecto
}
