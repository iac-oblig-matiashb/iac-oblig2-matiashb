output "vm_public_ips" {
  description = "Offentlig IP per VM-tjeneste, lest fra eksisterende Azure-ressurser."
  value       = { for navn, ip in data.azurerm_public_ip.vm : navn => ip.ip_address }
}

output "webapp_hostnames" {
  description = "Adresse per webapp-tjeneste."
  value       = { for navn, runtime in var.tjenester : navn => "app-${var.kortnavn}-${navn}-${var.miljo}.azurewebsites.net" if runtime == "webapp" }
}
