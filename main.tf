#Consumer BU Project
resource "tfe_project" "this" {
  name         = var.project_name
  organization = var.organization_name
}

resource "tfe_project_variable_set" "project" {
  count           = var.create_variable_set ? 1 : 0
  variable_set_id = module.terraform-tfe-variable-sets[0].variable_set[0].id
  project_id      = tfe_project.this.id
}

# TO PIN MODULE VERSION
module "terraform-tfe-variable-sets" {
  source = "github.com/hashi-demo-lab/terraform-tfe-variable-sets"
  count  = var.create_variable_set ? 1 : 0

  organization             = var.organization_name
  create_variable_set      = var.create_variable_set
  variables                = try(var.varset.variables, {})
  variable_set_name        = try(var.varset.variable_set_name, "")
  variable_set_description = try(var.varset.variable_set_description, "")
  tags                     = try(var.varset.tags, [])
  global                   = try(var.varset.global, false)
}


resource "tfe_team" "this" {
  for_each = var.team_project_access

  name         = each.key
  organization = var.organization_name
  sso_team_id  = try(each.value.team.sso_team_id, null)
}

resource "tfe_team" "custom" {
  for_each = var.custom_team_project_access

  name         = each.key
  organization = var.organization_name
  sso_team_id  = try(each.value.team.sso_team_id, null)
}

resource "tfe_team_project_access" "default" {
  for_each = var.team_project_access

  access     = each.value.team.access
  team_id    = tfe_team.this[each.key].id
  project_id = tfe_project.this.id
}

resource "tfe_team_project_access" "custom" {
  for_each = var.custom_team_project_access

  access     = each.value.team.access
  team_id    = tfe_team.custom[each.key].id
  project_id = tfe_project.this.id

  project_access {
    settings = try(each.value.project_access.settings, "read")
    teams    = try(each.value.project_access.teams, "none")
  }

  workspace_access {
    runs           = try(each.value.workspace_access.runs, "read")
    sentinel_mocks = try(each.value.workspace_access.sentinel_mocks, "none")
    state_versions = try(each.value.workspace_access.state_versions, "none")

    variables = try(each.value.workspace_access.variables, "none")
    create    = try(each.value.workspace_access.create, false)
    locking   = try(each.value.workspace_access.locking, false)
    delete    = try(each.value.workspace_access.delete, false)
    move      = try(each.value.workspace_access.move, false)
    run_tasks = try(each.value.workspace_access.run_tasks, false)
  }
}


# bu-control(x)
resource "tfe_project" "bu-control" {
  name         = var.bu-control_project_name
  organization = var.organization_name
}

# Control Workspace will be API driven
resource "tfe_workspace" "bu-control" {
  name = var.bu-control_workspace
  organization = var.organization_name
  project_id = tfe_project.bu-control.id
  allow_destroy_plan = false
}


 
