resource "tfe_project" "this" {
  name         = var.project_name
  organization = var.organization_name
}