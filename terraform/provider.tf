terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "0.1.0-beta1"
    }
  }
}

provider "btp" {
  globalaccount = "ticrossa"
}

// Configuration is described in https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs
provider "cloudfoundry" {
  api_url  = "https://api.cf.us10.hana.ondemand.com"
}