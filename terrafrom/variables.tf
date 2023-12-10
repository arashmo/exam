# Global variable accorss the project 
variable "resource_group_name" {
  description = "BASF Resource "
  default     = "myResourceGroup"
  }

variable "location" {
  description = "The location/region of the resource group"
  type        = "West Europe"
}



