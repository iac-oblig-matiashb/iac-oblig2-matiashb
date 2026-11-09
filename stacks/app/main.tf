# PR 2: migrer VM og webapp ut av gammel app.tfstate.
# Lesbare legacy outputs beholdes så rapporteringen i kjor.sh er som før.
data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = "oblig2/${var.miljo}/network.tfstate"
    use_azuread_auth     = true
  }
}

locals {
  network = data.terraform_remote_state.network.outputs
}

data "azurerm_public_ip" "vm" {
  for_each            = { for navn, runtime in var.tjenester : navn => runtime if runtime == "vm" }
  name                = "pip-${each.key}"
  resource_group_name = local.network.resource_group_name
}

removed {
  from = module.vm
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.webapp
  lifecycle {
    destroy = false
  }
}
