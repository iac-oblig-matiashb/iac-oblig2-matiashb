# Flytt ressursgruppe og VNet fra network.tfstate til shared-network.tfstate.
# ID-er leses fra Azure og er derfor ikke hardkodet.
import {
  to = azurerm_resource_group.this
  id = data.azurerm_resource_group.existing.id
}

import {
  to = module.vnet.azurerm_virtual_network.this
  id = data.azurerm_virtual_network.existing.id
}
