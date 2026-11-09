output "subnet_id" {
  description = "ID-en til tjenestens subnett."
  value       = module.subnet.subnet_id
}

output "storage_account_name" {
  description = "Navnet til tjenestens storage account."
  value       = module.storage.name
}

output "key_vault_name" {
  description = "Navnet til tjenestens Key Vault."
  value       = module.keyvault.name
}

output "vm_public_ip" {
  description = "Offentlig IP når runtime er vm; ellers null."
  value       = try(module.vm[var.service].public_ip, null)
}

output "webapp_hostname" {
  description = "Hostnavn når runtime er webapp; ellers null."
  value       = try(module.webapp[var.service].hostname, null)
}
