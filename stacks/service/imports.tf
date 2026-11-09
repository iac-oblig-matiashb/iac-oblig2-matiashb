# PR 2: alle import-ID-er bygges fra eksisterende Azure-ressurs-ID-er,
# aldri med hardkodet abonnement-ID. Det finnes én instans per tjeneste.
locals {
  rg_id   = data.azurerm_resource_group.existing.id
  vnet_id = "${local.rg_id}/providers/Microsoft.Network/virtualNetworks/${local.shared.vnet_name}"
  snet_id = "${local.vnet_id}/subnets/snet-${var.service}"
  nsg_id  = "${local.rg_id}/providers/Microsoft.Network/networkSecurityGroups/nsg-${var.service}"
}

import {
  to = module.subnet.azurerm_subnet.this
  id = local.snet_id
}

import {
  to = module.subnet.azurerm_network_security_group.this
  id = local.nsg_id
}

import {
  to = module.subnet.azurerm_network_security_rule.http
  id = "${local.nsg_id}/securityRules/allow-http"
}

# Association-ressursens import-ID er subnettets ID, ikke NSG-ID-en.
import {
  to = module.subnet.azurerm_subnet_network_security_group_association.this
  id = local.snet_id
}

import {
  to = module.storage.azurerm_storage_account.this
  id = "${local.rg_id}/providers/Microsoft.Storage/storageAccounts/st${var.kortnavn}${var.service}${var.miljo}"
}

import {
  to = module.keyvault.azurerm_key_vault.this
  id = "${local.rg_id}/providers/Microsoft.KeyVault/vaults/kv-${var.kortnavn}-${var.service}-${var.miljo}"
}

import {
  for_each = var.runtime == "vm" ? toset([var.service]) : toset([])
  to       = module.vm[each.key].azurerm_public_ip.this
  id       = "${local.rg_id}/providers/Microsoft.Network/publicIPAddresses/pip-${each.key}"
}

import {
  for_each = var.runtime == "vm" ? toset([var.service]) : toset([])
  to       = module.vm[each.key].azurerm_network_interface.this
  id       = "${local.rg_id}/providers/Microsoft.Network/networkInterfaces/nic-${each.key}"
}

import {
  for_each = var.runtime == "vm" ? toset([var.service]) : toset([])
  to       = module.vm[each.key].azurerm_linux_virtual_machine.this
  id       = "${local.rg_id}/providers/Microsoft.Compute/virtualMachines/vm-${each.key}"
}

import {
  for_each = var.runtime == "webapp" ? toset([var.service]) : toset([])
  to       = module.webapp[each.key].azurerm_service_plan.this
  id       = "${local.rg_id}/providers/Microsoft.Web/serverFarms/asp-${each.key}"
}

import {
  for_each = var.runtime == "webapp" ? toset([var.service]) : toset([])
  to       = module.webapp[each.key].azurerm_linux_web_app.this
  id       = "${local.rg_id}/providers/Microsoft.Web/sites/app-${var.kortnavn}-${each.key}-${var.miljo}"
}
