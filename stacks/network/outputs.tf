# Beholdes under overgangen: data/app leser fortsatt network.tfstate.
output "resource_group_name" {
  description = "Ressursgruppen til alle stackene."
  value       = data.azurerm_resource_group.existing.name
}

output "location" {
  description = "Regionen til ressursgruppen."
  value       = data.azurerm_resource_group.existing.location
}

output "vnet_name" {
  description = "Navnet til eksisterende VNet."
  value       = data.azurerm_virtual_network.existing.name
}

output "subnet_ids" {
  description = "Subnett-ID per tjeneste."
  value       = { for navn, s in module.subnet : navn => s.subnet_id }
}
