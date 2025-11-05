output "project_id" {
  value       = tfe_project.consumer.id
  description = "The ID of the TFE project"
}

output "project_name" {
  value       = tfe_project.consumer.name
  description = "The name of the TFE project"
}


output "project_map" {
  value       = tomap({ (tfe_project.consumer.name) = { "project_id" = tfe_project.consumer.id, "bu" = var.business_unit } })
  description = "Map of project name to project details"
}

output "bu" {
  value       = var.business_unit
  description = "The business unit associated with this project"
}

output "team" {
  value       = tfe_team.this
  description = "TFE teams with pre-defined RBAC roles"
}

output "team_custom" {
  value       = tfe_team.custom
  description = "TFE teams with custom RBAC roles"
}

output "enable_oidc" {
  value       = var.enable_oidc
  description = "Whether OIDC is enabled for this project"
}

output "details" {
  value = {
    project_id    = tfe_project.consumer.id
    project_name  = tfe_project.consumer.name
    business_unit = var.business_unit
    enable_oidc   = var.enable_oidc
  }
  description = "Summary of all project details in a single output"
}
