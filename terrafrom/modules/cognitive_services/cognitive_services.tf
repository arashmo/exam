# Existing Resources
resource "azurerm_resource_group" "challenge-rg" {
  name     = var.name 
  location = var.location
}

resource "azurerm_virtual_network" "challenge-vnet" {
  name                = "challenge-vnet"
  address_space       = var.vnet_address_space # le'ts read it from name string 
  location            = azurerm_resource_group.challenge-rg.location
  resource_group_name = azurerm_resource_group.challenge-rg.name
}

resource "azurerm_subnet" "challenge-subnet" {
  name                 = "challenge-subnet"
  resource_group_name  = azurerm_resource_group.challenge-rg.name
  virtual_network_name = azurerm_virtual_network.challenge-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Cognitive Services Account
resource "azurerm_cognitive_account" "cognitive_account" {
  name                  = "example-cognitive-account"
  location              = azurerm_resource_group.challenge-rg.location
  resource_group_name   = azurerm_resource_group.challenge-rg.name
  kind                  = "CognitiveServices"
  sku_name              = "S0" # Adjust SKU as needed

  identity {
    type = "SystemAssigned"
  }
}

# Private Endpoint
resource "azurerm_private_endpoint" "cognitive_private_endpoint" {
  name                = "example-cognitive-private-endpoint"
  location            = azurerm_resource_group.challenge-rg.location
  resource_group_name = azurerm_resource_group.challenge-rg.name
  subnet_id           = azurerm_subnet.challenge-subnet.id

  private_service_connection {
    name                           = "cognitive-private-connection"
    private_connection_resource_id = azurerm_cognitive_account.cognitive_account.id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }
}

# Network Security to restrict access to the Private Endpoint only
resource "azurerm_network_security_group" "nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.challenge-rg.location
  resource_group_name = azurerm_resource_group.challenge-rg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.challenge-subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
