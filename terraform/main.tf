locals {
  uuid = uuid()
}

###
# Creation of subaccount
###
resource "btp_subaccount" "project" {
  name      = var.subaccount_name
  subdomain = local.uuid
  region    = lower("${var.region}")
}

###
# Assignment of emergency admins to the sub account as sub account administrators
###
resource "btp_subaccount_role_collection_assignment" "subaccount_users" {
  for_each = toset("${var.app_admins}")
    subaccount_id        = btp_subaccount.project.id
    role_collection_name = "Subaccount Administrator"
    user_name     = each.value
}

###
# Creation of Cloud Foundry environment
###
module "cloudfoundry_environment" {
  source = "github.com/SAP-samples/btp-terraform-samples/released/modules/envinstance-cloudfoundry/"

  subaccount_id         = btp_subaccount.project.id
  instance_name         = replace(local.uuid, "-", "")
  cloudfoundry_org_name = replace(local.uuid, "-", "")
}

resource "btp_subaccount_entitlement" "entitlements" {

  for_each   = {
    for index, entitlement in var.entitlements:
    index => entitlement
  }

  subaccount_id = btp_subaccount.project.id
  service_name  = each.value.name
  plan_name     = each.value.plan
}
