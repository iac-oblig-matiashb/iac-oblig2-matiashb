variable "kortnavn" {
  description = "Kortnavnet fra config/felles.tfvars."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{2,10}$", var.kortnavn))
    error_message = "Kortnavnet må være 2–10 små bokstaver eller tall."
  }
}

variable "miljo" {
  description = "Miljøet, dev eller prod."
  type        = string
  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo må være dev eller prod."
  }
}

variable "location" {
  description = "Azure-regionen fra config/felles.tfvars."
  type        = string
}

variable "state_resource_group_name" {
  description = "Ressursgruppen for remote Terraform state."
  type        = string
}

variable "state_storage_account_name" {
  description = "Storage account for remote Terraform state."
  type        = string
}

variable "state_container_name" {
  description = "Blob-container for remote Terraform state."
  type        = string
}

variable "service" {
  description = "Tjenestenavn, eksempelvis ordre, meny eller en ny tjeneste."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]+$", var.service))
    error_message = "Tjenestenavnet må inneholde små bokstaver og tall."
  }
}

variable "runtime" {
  description = "Kjøremiljøet: vm eller webapp."
  type        = string
  validation {
    condition     = contains(["vm", "webapp"], var.runtime)
    error_message = "runtime må være vm eller webapp."
  }
}

variable "subnet_prefix" {
  description = "Eksisterende eller ønsket subnettprefiks, innenfor VNet-ets adresserom."
  type        = string
}

variable "allow_http_from" {
  description = "Kilde til HTTP-regelen i tjenestens NSG."
  type        = string
  default     = "Internet"
}

variable "vm_size" {
  description = "VM-størrelse for en tjeneste med runtime vm."
  type        = string
  default     = "Standard_B2als_v2"
}

variable "ssh_public_key" {
  description = "Offentlig SSH-nøkkel når runtime er vm. Aldri legg inn privat nøkkel."
  type        = string
  default     = ""
}

variable "webapp_sku" {
  description = "SKU til App Service-planen når runtime er webapp."
  type        = string
  default     = "B1"
}
