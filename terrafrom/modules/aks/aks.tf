variable "location" {}
variable "resource_group_name" {}

resource "azurerm_kubernetes_cluster" "challenge-aks" {
  name                = "challenge-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "challengeaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

