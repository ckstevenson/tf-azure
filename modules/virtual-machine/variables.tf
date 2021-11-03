variable "vm_name" {
  type        = string
  description = "Virtual machine name."
  default     = ""
}

variable "os_type" {
  type        = string
  description = "Type os OS, linux or windows."
  default     = ""
}

variable "username" {
  type        = string
  description = "Username for the created superuser/admin user."
  default     = ""
}

variable "password" {
  type        = string
  description = "Password for the created user."
  default     = ""
}

variable "if_name" {
  type        = string
  description = "Interface name for the VM."
  default     = ""
}

variable "public_ip_name" {
  type        = string
  description = "Public IP resource name."
  default     = ""
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet for the related the network components."
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "Virtual network name for the related network resources."
  default     = ""
}

variable "vm_rg_name" {
  type        = string
  description = "Virtual machine resource group name."
  default     = ""
}

variable "subnet_rg_name" {
  type    = string
  default = "Subnet resource group name."
}

variable "vm_tags" {
  type        = map(any)
  description = "Tags to attach to the VM."
  default     = {}
}

#https://docs.microsoft.com/en-us/azure/backup/backup-azure-policy-supported-skus
variable "vm_sri" {
  type        = map(any)
  description = "The source image reference for the VM."
  default     = {}
}
