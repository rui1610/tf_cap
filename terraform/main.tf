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

###
# Create Cloud Foundry space and assign users
###
module "cloudfoundry_space" {
  source = "github.com/SAP-samples/btp-terraform-samples/released/modules/cloudfoundry-space/"
  cf_org_id           = module.cloudfoundry_environment.org_id
  name                = "development"
  cf_space_managers   = var.app_admins
  cf_space_developers = var.app_admins
  cf_space_auditors   = var.app_admins
}

resource "btp_subaccount_entitlement" "hana_cloud" {
  subaccount_id = btp_subaccount.project.id
  service_name  = "hana-cloud"
  plan_name     = "hana-free"
}

resource "btp_subaccount_entitlement" "hana" {
  subaccount_id = btp_subaccount.project.id
  service_name  = "hana"
  plan_name     = "hdi-shared"
}

data "btp_subaccount_service_plan" "by_name_hana_cloud" {
  subaccount_id = btp_subaccount.project.id
  offering_name = "hana-cloud"
  name          = "hana-free"
}

resource "btp_subaccount_service_instance" "hana-cloud-hana-free" {
  subaccount_id  = btp_subaccount.project.id
  # The service plan ID can be looked up via the data source btp_subaccount_service_plan
  serviceplan_id = btp_subaccount_service_plan.by_name_hana_cloud.id
  name           = "my-hana-cloud-instance"
  parameters = jsonencode({
    data = {
      edition   = "cloud"
      memory = 30
      serviceStopped = false
      storage = 120
      systempassword = "PleaseChangeBeforeRunningScript12345"
      vcpu = 2
      versionIndicator = ""
      whitelistIPs = ["0.0.0.0/0"]
    }
  })
        #"data": {
        #  "edition": "cloud",
        #  "memory": 30,
        #  "serviceStopped": false,
        #  "storage": 120,
        #  "systempassword": "PleaseChangeBeforeRunningScript12345",
        #  "vcpu": 2,
        #  "versionIndicator": "",
        #  "whitelistIPs": [
        #   "0.0.0.0/0"
        #  ]
        #}
}

data "btp_subaccount_service_plan" "by_name_hana" {
  subaccount_id = btp_subaccount.project.id
  offering_name = "hana"
  name          = "hdi-shared"
}

resource "btp_subaccount_service_instance" "hana-hdi-shared" {
  subaccount_id  = btp_subaccount.project.id
  # The service plan ID can be looked up via the data source btp_subaccount_service_plan
  serviceplan_id = btp_subaccount_service_plan.by_name_hana.id
  name           = "my-hana-hdi-shared-instance"
  parameters = jsonencode({
    xsappname   = "my-application"
    tenant-mode = "dedicated"
  })
}
