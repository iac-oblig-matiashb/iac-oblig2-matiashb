variable "kortnavn" {
  description = "Kortnavnet ditt fra config/felles.tfvars."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.kortnavn))
    error_message = "kortnavn må være 2–10 små bokstaver eller tall."
  }
}

variable "location" {
  description = "Azure-regionen fra config/felles.tfvars."
  type        = string
}

variable "miljo" {
  description = "dev eller prod, settes av scripts/kjor.sh."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo må være dev eller prod."
  }
}

variable "address_space" {
  description = "Eksisterende adresseområde til VNet-et."
  type        = list(string)
}
