output "project_id" {
  value = tfe_project.consumer.id
  description = "tfe project"
}

output "project_name" {
  value = tfe_project.consumer.name
  description = "tfe project"
}

output "team" {
  value = tfe_team.this
  description = "tfe teams pre-defined rbac"
}

output "team_custom" {
  value = tfe_team.custom
  description = "tfe teams custom rbac"
}