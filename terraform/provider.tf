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
