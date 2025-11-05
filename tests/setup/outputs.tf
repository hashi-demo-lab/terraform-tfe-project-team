output "bu_control_project_id" {
  value       = tfe_project.bu-control.id
  description = "project id for bu control project"
}

output "bu_control_team_id" {
  value       = tfe_team.bu-control-admins.id
  description = "team id for bu control project team"
}
