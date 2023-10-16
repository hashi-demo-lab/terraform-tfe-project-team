# bu-control(x) ## this can like be moved outside module and substited with id to simplify for_each on module
resource "tfe_project" "bu-control" {
  name         = var.bu_control_project_name
  organization = var.organization_name
}

# Control Workspace will be API driven
resource "tfe_workspace" "bu-control" {
  name = var.bu_control_workspace
  organization = var.organization_name
  project_id = tfe_project.bu-control.id
  allow_destroy_plan = false
}

resource "tfe_team" "bu-control-admins" {
  name         = "${var.bu_control_project_name}-admins"
  organization = var.organization_name
  sso_team_id  = null #to add vars for bu-control sso id
}