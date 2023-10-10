resource "tfe_project" "this" {
  name         = var.project_name
  organization = var.organization_name
}

resource "tfe_team" "this" {
  name = var.team_name
}

resource "tfe_team_project_access" "default" {
  for_each = var.team_project_access

  access     = each.value
  team_id    = tfe_team.this.id
  project_id = tfe_project.this.id
}

resource "tfe_team_project_access" "custom" {
  for_each = var.custom_team_project_access

  access     = "custom"
  team_id    = tfe_team.this.id
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