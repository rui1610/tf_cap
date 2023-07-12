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

###
# Call module for creating entitlements
###
module "add_entitlements" {
  for_each   = {
    for index, entitlement in var.entitlements:
    index => entitlement
  }

    source    = "./add_entitlement/"
    subaccount_id           = btp_subaccount.project.id
    service_name            = each.value.service_name
    service_plan_name       = each.value.plan_name
}

/*
parameters for hana-cloud and hana service plan
{
    "data": {
        "memory": 30,
        "edition": "cloud",
        "systempassword": "Abcd1234"
    }
}
*/


/*
data "cloudfoundry_service" "hana" {
  name = "hana"
}

data "cloudfoundry_service" "hana-cloud" {
  name = "hana-cloud"
}


resource "cloudfoundry_service_instance" "hana" {
  name         = "helloterraform-xsuaa"
  space        = data.cloudfoundry_space.dev.id
  service_plan = data.cloudfoundry_service.xsuaa.service_plans["application"]
  json_params = jsonencode({
    xsappname   = "helloterraform-${random_id.suffix.hex}"
    tenant-mode = "shared"
    scopes = [
      {
        name        = "helloterraform-${random_id.suffix.hex}.Display"
        description = "Display"
      },
    ]
    role-templates = [
      {
        name        = "Viewer"
        description = ""
        scope-references = [
          "helloterraform-${random_id.suffix.hex}.Display"
        ]
      }
    ]
  })
}


data "btp_subaccount_service_plan" "by_name_hana" {
  subaccount_id = btp_subaccount.project.id
  offering_name = "hana"
  name          = "hdi-shared"
  depends_on    = btp_subaccount_entitlement.hana
}

data "btp_subaccount_service_plan" "by_name_hana_cloud" {
  subaccount_id = btp_subaccount.project.id
  offering_name = "hana-cloud"
  name          = "hana-free"
  depends_on    = btp_subaccount_entitlement.hana_cloud
}

resource "btp_subaccount_service_instance" "hana-cloud-hana-free" {
  subaccount_id  = btp_subaccount.project.id
  # The service plan ID can be looked up via the data source btp_subaccount_service_plan
  serviceplan_id = data.btp_subaccount_service_plan.by_name_hana_cloud.id
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



resource "btp_subaccount_service_instance" "hana-hdi-shared" {
  subaccount_id  = btp_subaccount.project.id
  # The service plan ID can be looked up via the data source btp_subaccount_service_plan
  serviceplan_id = data.btp_subaccount_service_plan.by_name_hana.id
  name           = "my-hana-hdi-shared-instance"
  parameters = jsonencode({
    xsappname   = "my-application"
    tenant-mode = "dedicated"
  })
}
*/