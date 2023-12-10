variable "aks_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "challenge-aks-cluster"
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = "challengeaks"
}

variable "aks_node_pool_name" {
  description = "Name of the default node pool in the AKS cluster"
  type        = string
  default     = "default"
}

variable "aks_node_count" {
  description = "Node count for the default node pool in the AKS cluster"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "VM size for the nodes in the default node pool"
  type        = string
  default     = "Standard_DS2_v2"
}
