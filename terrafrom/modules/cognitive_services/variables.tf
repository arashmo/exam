variable "name" {
  type = string
  description = "The name of the Cognitive Services account"
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group"
  
}

variable "location" {
  description = "The location/region of the resource group"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


