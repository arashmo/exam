provider "azurerm" {
  features {}
}

module "aks" {
  source = "./modules/aks"
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "kubernetes" {
  source = "./modules/kubernetes"
  location   = var.location
  resource_group_name = var.resource_group_name
}
module "kubernetes" {
  source = "./modules/cogntive_services"
  location   = var.location
  resource_group_name = var.resource_group_name # will be over written by local folder 
}

module "kustomize_deployment" {
  source = "./modules/kustomize_deployment"
  kustomize_directory = "${path.root}/kustomize/"
}