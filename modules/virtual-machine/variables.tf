variable "vm_name" {
  type = string
  default = ""
}

variable "os_type" {
  type = string
  default = ""
}

variable "username" {
  type = string
  default = ""
}

variable "password" {
  type = string
  default = ""
}

variable "if_name" {
  type = string
  default = ""
}

variable "public_ip_name" {
  type = string
  default = ""
}

variable "subnet_name" {
  type = string
  default = ""
}

variable "vnet_name" {
  type = string
  default = ""
}

variable "vm_rg_name" {
  type = string
  default = ""
}

variable "subnet_rg_name" {
  type = string
  default = ""
}

variable "vm_tags" {
  type = map
  default = {}
}

#https://docs.microsoft.com/en-us/azure/backup/backup-azure-policy-supported-skus
variable "vm_sri" {
  type = map
  default = {}
}
