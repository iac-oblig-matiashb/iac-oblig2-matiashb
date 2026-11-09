# Bevar gamle output-verdier til oppryddings-PR-en.
output "storage_account_names" {
  description = "Storage account per tjeneste."
  value       = { for navn in var.tjenester : navn => "st${var.kortnavn}${navn}${var.miljo}" }
}

output "key_vault_names" {
  description = "Key Vault per tjeneste."
  value       = { for navn in var.tjenester : navn => "kv-${var.kortnavn}-${navn}-${var.miljo}" }
}
