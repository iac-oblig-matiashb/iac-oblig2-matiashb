output "resource_group_name" {
  description = "Navnet til felles ressursgruppe."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Regionen til felles ressursgruppe."
  value       = azurerm_resource_group.this.location
}

output "vnet_name" {
  description = "Navnet til felles VNet."
  value       = module.vnet.name
}
