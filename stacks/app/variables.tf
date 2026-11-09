variable "kortnavn" {
  description = "Kortnavnet ditt fra config/felles.tfvars."
  type        = string
}

variable "miljo" {
  description = "Miljøet (dev eller prod)."
  type        = string
}

variable "state_resource_group_name" {
  description = "Ressursgruppa til state-kontoen."
  type        = string
}

variable "state_storage_account_name" {
  description = "State-kontoens navn."
  type        = string
}

variable "state_container_name" {
  description = "Containeren til state."
  type        = string
}

variable "tjenester" {
  description = "Tjenestene og kjøremiljøet deres."
  type        = map(string)
}
