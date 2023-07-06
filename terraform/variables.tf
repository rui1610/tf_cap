variable "region" {
  type        = string
  description = "Defines to which organisation the sub account shall belong to."
  default     = "us10"
}

variable "subaccount_name" {
  type        = string
  description = "Defines the name of the sub account."
  default     = "Demo CAP app"
}

variable "app_admins" {
  type        = list(string)
  description = "Defines the administrators for the sub account and app."
  default     = ["rui.nogueira@sap.com","jeremias.roessler@sap.com"]
}

###
# Entitlements
###
variable "entitlements" {
  description = "List of entitlements for a BTP subaccount"
    type = list(object({
      group = string
      type  = string
      name = string
      plan = string
      amount = number
  }))

  default = [
    {
      group = "SAP HANA Cloud"
      type  = "service"
      name = "hana-cloud"
      plan = "hana"
      amount = null
    },
    {
      group = "SAP HANA Cloud"
      type  = "service"
      name = "hana"
      plan = "hdi-shared"
      amount = null
    }
  ]
}
