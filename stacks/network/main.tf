# Overgangsstack: nettverkseierskap flyttes til shared-network og service.
# network.tfstate beholder outputs til de gamle app/data-stackene er fjernet.
data "azurerm_resource_group" "existing" {
  name = "rg-${var.kortnavn}-oblig2-${var.miljo}"
}

data "azurerm_virtual_network" "existing" {
  name                = "vnet-${var.kortnavn}-${var.miljo}"
  resource_group_name = data.azurerm_resource_group.existing.name
}

data "azurerm_subnet" "existing" {
  for_each             = var.tjenester
  name                 = "snet-${each.key}"
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = data.azurerm_virtual_network.existing.name
}

# PR 1: disse to er allerede overført til shared-network.
removed {
  from = azurerm_resource_group.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.vnet
  lifecycle {
    destroy = false
  }
}

# PR 2: åtte ressurser (4 per tjeneste) overføres til service.
removed {
  from = module.subnet
  lifecycle {
    destroy = false
  }
}
