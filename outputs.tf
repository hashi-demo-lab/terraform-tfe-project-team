output "project_id" {
  value       = tfe_project.consumer.id
  description = "tfe project"
}

output "project_name" {
  value       = tfe_project.consumer.name
  description = "tfe project"
}


output "project_map" {
  value       = tomap({ (tfe_project.consumer.name) = { "project_id" = tfe_project.consumer.id, "bu" = var.business_unit } })
  description = "tfe project map"
}

output "bu" {
  value       = var.business_unit
  description = "tfe project"
}

output "team" {
  value       = tfe_team.this
  description = "tfe teams pre-defined rbac"
}

output "team_custom" {
  value       = tfe_team.custom
  description = "tfe teams custom rbac"
}

output "enable_oidc" {
  value       = var.enable_oidc
  description = "enable oidc"
}

output "name" {
  value       = tfe_project.consumer.name
  description = "tfe project name"
}
