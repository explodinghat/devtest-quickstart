terraform {
  required_version = ">= 1.3"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      version = "~>3.2"
      source  = "hashicorp/azurerm"
    }
  }
}
provider "azurerm"{
    features{}
}
resource "azurerm_resource_group" "devtestlab" {
  name     = "devtestlab-${var.DEVTEST_ID}-rg"
  location = "UKWest"
}

resource "azurerm_dev_test_lab" "example" {
  name                = "devtestlab-${var.DEVTEST_ID}"
  location            = azurerm_resource_group.devtestlab.location
  resource_group_name = azurerm_resource_group.devtestlab.name

  tags = {
    "Automated" = "True"
  }
}
resource "azurerm_dev_test_policy" "example" {
  name                = "LabVmCount"
  policy_set_name     = "default"
  lab_name            = azurerm_dev_test_lab.example.name
  resource_group_name = azurerm_resource_group.devtestlab.name
  fact_data           = ""
  threshold           = "5"
  evaluator_type      = "MaxValuePolicy"
}
resource "azurerm_network_security_group" "example" {
  name                = "devtestlab-${var.DEVTEST_ID}-nsg"
  location            = azurerm_resource_group.devtestlab.location
  resource_group_name = azurerm_resource_group.devtestlab.name
}

resource "azurerm_virtual_network" "example" {
  name                = "devtestlab-${var.DEVTEST_ID}-vnet"
  location            = azurerm_resource_group.devtestlab.location
  resource_group_name = azurerm_resource_group.devtestlab.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["8.8.8.8"]

  subnet {
    name           = "devtestlab-${var.DEVTEST_ID}-subnet1"
    address_prefix = "10.0.0.0/24"
  }
}