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

variable "entitlements" {
  type = list(object({
      service_name = string
      plan_name    = string
  }))
  description = "List of entitlements for a BTP subaccount"

  default = [
    {
      service_name = "hana-cloud"
      plan_name    = "hana"
    },
    {
    service_name = "hana"
     plan_name    = "hdi-shared"
    }
  ]


}