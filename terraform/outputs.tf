output "subaccount_id" {
  value       = btp_subaccount.project.id
  description = "The ID of the project subaccount."
}

output "region" {
  value       = var.region
  description = "The name of the project subaccount."
}

output "subaccount_name" {
  value       = btp_subaccount.project.name
  description = "The name of the project subaccount."
}

output "cloudfoundry_org_id" {
  value       = module.cloudfoundry_environment.org_id
  description = "The instance_name of the cf environment."
}

#output "cloudfoundry_org_name" {
#  value       = cloudfoundry_environment.cloudfoundry_org_name
#  description = "The cloudfoundry_org_name of the cf environment."
#}
