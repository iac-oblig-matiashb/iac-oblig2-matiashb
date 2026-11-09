# Outputene må beholdes så app-stacken kan lese gammel network.tfstate
# i overgangsperioden fram til alle eierskap er flyttet.
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
  description = "Subnett-ID per tjeneste, lest fra Azure etter at eierskapet er gitt fra seg."
  value       = { for navn, s in data.azurerm_subnet.existing : navn => s.id }
}
