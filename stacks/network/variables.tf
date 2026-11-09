variable "kortnavn" {
  description = "Kortnavnet ditt. Settes i config/felles.tfvars."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.kortnavn))
    error_message = "kortnavn må være 2–10 små bokstaver eller tall."
  }
}

variable "miljo" {
  description = "Miljøet. Settes av scripts/kjor.sh."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo må være dev eller prod."
  }
}

variable "tjenester" {
  description = "Tjenestenavn og opprinnelige subnettinnstillinger brukt under overgangen."
  type = map(object({
    prefix  = string
    runtime = string
  }))
}
