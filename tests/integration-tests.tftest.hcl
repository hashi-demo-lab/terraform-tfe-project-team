variables {
  project_name               = "tftest_project"
  organization_name          = "hashi-demos-apj"
  team_project_access        = {}
  custom_team_project_access = {}
  create_variable_set        = false
  varset = {
    variables                = {}
    variable_set_name        = "test_varset"
    variable_set_description = "Test variable set"
    tags                     = []
    global                   = false
  }

}

run "setup_bu_control" {
  
  variables {
    organization_name = "hashi-demos-apj"
    bu_control_project_name = "test_platform_project"
    bu_control_workspace = "test-bu1-workspace"
  }

  command = apply
  module {
    source = "./tests/setup"
  }

}

run "project_creation" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  assert {
    condition     = tfe_project.this.name == "tftest_project"
    error_message = "Project name is incorrect"
  }

  assert {
    condition     = tfe_project.this.organization == "hashi-demos-apj"
    error_message = "Organization name is incorrect"
  }
}

run "variable_set_creation" {
  variables {
    create_variable_set = true
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  assert {
    condition     = tfe_project_variable_set.project[0].variable_set_id == module.terraform-tfe-variable-sets[0].variable_set[0].id
    error_message = "Variable set ID is incorrect"
  }

  assert {
    condition     = tfe_project_variable_set.project[0].project_id == tfe_project.this.id
    error_message = "Project ID is incorrect"
  }
}

run "novarset-novariables" {
  # Load and count the objects created in the "execute" run block.
  variables {
  organization_name = "hashi-demos-apj"
  project_name      = "tftest-project-testadmin"

  team_project_access = {
    "team1" = {
      team = {
        access      = "read"
        sso_team_id = null
      }
    }
  }

  custom_team_project_access = {}

  varset = {
    variables         = {}
    variable_set_name = "tftest-project-varset"
  }
  create_variable_set   = true
  bu_control_admins_id = run.setup_bu_control.bu_control_team_id
}  

  command = apply

  assert {
    condition     = tfe_project.this.name == "tftest-project-testadmin"
    error_message = "Project names matched - tftest-project-testadmin"
  }

  assert {
    condition     = module.terraform-tfe-variable-sets[0].variable_set[0].name == "tftest-project-varset"
    error_message = "varset name matched - tftest-project-varset"
  }

}

run "team_creation" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
    team_project_access = {
      "team1" = {
        team = {
          access      = "read"
          sso_team_id = null
        }
      }
    }
    custom_team_project_access = {
      "team2" = {
        team = {
          access      = "custom"
          sso_team_id = null
        }
        project_access = {
          settings = "read"
          teams    = "none"
        }
        workspace_access = {
          runs           = "read"
          sentinel_mocks = "none"
          state_versions = "none"
          variables      = "none"
          create         = false
          locking        = false
          delete         = false
          move           = false
          run_tasks      = false
        }
      }
    }
  }

  assert {
    condition     = tfe_team.this["team1"].name == "team1"
    error_message = "Team name is incorrect"
  }

  assert {
    condition     = tfe_team.this["team1"].organization == "hashi-demos-apj"
    error_message = "Organization name is incorrect"
  }

  assert {
    condition     = tfe_team.custom["team2"].name == "team2"
    error_message = "Custom team name is incorrect"
  }

  assert {
    condition     = tfe_team.custom["team2"].organization == "hashi-demos-apj"
    error_message = "Organization name is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.default["team1"].access == "read"
    error_message = "Access level is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.default["team1"].team_id == tfe_team.this["team1"].id
    error_message = "Team ID is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.default["team1"].project_id == tfe_project.this.id
    error_message = "Project ID is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.custom["team2"].access == "custom"
    error_message = "Access level is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.custom["team2"].team_id == tfe_team.custom["team2"].id
    error_message = "Team ID is incorrect"
  }

  assert {
    condition     = tfe_team_project_access.custom["team2"].project_id == tfe_project.this.id
    error_message = "Project ID is incorrect"
  }
}