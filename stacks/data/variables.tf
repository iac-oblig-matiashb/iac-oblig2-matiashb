variable "kortnavn" {
  description = "Kortnavnet ditt fra config/felles.tfvars."
  type        = string
}

variable "miljo" {
  description = "dev eller prod, settes av scripts/kjor.sh."
  type        = string
}

variable "tjenester" {
  description = "Tjenestene som har storage account og Key Vault."
  type        = set(string)
}
