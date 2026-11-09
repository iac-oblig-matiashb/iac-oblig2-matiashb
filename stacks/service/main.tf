# En Terraform-definisjon pr. tjenesteinstans.
# f.eks. config/dev/service-ordre.tfvars og service-meny.tfvars.
data "terraform_remote_state" "shared_network" {
  backend = "azurerm"
  config = {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = "oblig2/${var.miljo}/shared-network.tfstate"
    use_azuread_auth     = true
  }
}


data "azurerm_client_config" "current" {}

locals {
  shared = data.terraform_remote_state.shared_network.outputs
  tags = {
    eier  = var.kortnavn
    miljo = var.miljo
    kurs  = "dcst3005-oblig2"
  }
}

module "subnet" {
  source              = "../../modules/subnet"
  service             = var.service
  resource_group_name = local.shared.resource_group_name
  location            = var.location
  vnet_name           = local.shared.vnet_name
  prefix              = var.subnet_prefix
  delegate_web        = var.runtime == "webapp"
  allow_http_from     = var.allow_http_from
  extra_tcp_rules     = var.extra_tcp_rules
  tags                = local.tags
}

module "storage" {
  source              = "../../modules/storage"
  service             = var.service
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared.resource_group_name
  location            = var.location
  tags                = local.tags
}

module "keyvault" {
  source              = "../../modules/keyvault"
  service             = var.service
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
}

module "vm" {
  source   = "../../modules/vm"
  for_each = var.runtime == "vm" ? toset([var.service]) : toset([])

  service             = each.key
  resource_group_name = local.shared.resource_group_name
  location            = var.location
  subnet_id           = module.subnet.subnet_id
  size                = var.vm_size
  ssh_public_key      = var.ssh_public_key
  tags                = local.tags
}

module "webapp" {
  source   = "../../modules/webapp"
  for_each = var.runtime == "webapp" ? toset([var.service]) : toset([])

  service             = each.key
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared.resource_group_name
  location            = var.location
  subnet_id           = module.subnet.subnet_id
  sku                 = var.webapp_sku
  tags                = local.tags
}
