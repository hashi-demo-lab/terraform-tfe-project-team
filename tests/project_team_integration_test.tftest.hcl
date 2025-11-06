# ============================================================================
# INTEGRATION TESTS (Apply Mode) - Creates and validates real infrastructure
# ============================================================================
# This file contains integration tests using command = apply (creates real TFE resources)
# These tests validate the full module behavior including project, team, and variable set creation
# WARNING: These tests create real resources in TFE and may incur costs

# Default variable values for all run blocks in this file
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

# ============================================================================
# TEST FIXTURE SETUP
# ============================================================================
# Creates the BU control infrastructure needed for all integration tests
# This includes the platform project, workspace, and team

run "setup_bu_control" {

  variables {
    organization_name       = "hashi-demos-apj"
    bu_control_project_name = "test2_platform_project"
    bu_control_workspace    = "test2-bu1-workspace"
  }

  command = apply
  module {
    source = "./tests/setup"
  }

}

# ============================================================================
# INTEGRATION TEST 1: Basic Project Creation
# ============================================================================
# Tests that a basic project can be created with correct attributes

run "project_creation" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  command = apply

  assert {
    condition     = tfe_project.consumer.name == "tftest_project"
    error_message = "Project name should be 'tftest_project'"
  }

  assert {
    condition     = tfe_project.consumer.organization == "hashi-demos-apj"
    error_message = "Project organization should be 'hashi-demos-apj'"
  }
}

# ============================================================================
# INTEGRATION TEST 2: Variable Set Creation and Association
# ============================================================================
# Tests that variable sets are created and properly associated with the project

run "variable_set_creation" {
  variables {
    create_variable_set  = true
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  command = apply

  assert {
    condition     = tfe_project_variable_set.project[0].variable_set_id == module.terraform-tfe-variable-sets[0].variable_set[0].id
    error_message = "Variable set should be properly associated with the project"
  }

  assert {
    condition     = tfe_project_variable_set.project[0].project_id == tfe_project.consumer.id
    error_message = "Variable set association should reference the correct project ID"
  }
}

# ============================================================================
# INTEGRATION TEST 3: Complete Project with Teams and Variable Set
# ============================================================================
# Tests a complete configuration including project, teams, and variable set

run "complete_project_with_teams_and_varset" {
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
    create_variable_set  = true
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  command = apply

  assert {
    condition     = tfe_project.consumer.name == "tftest-project-testadmin"
    error_message = "Project name should be 'tftest-project-testadmin'"
  }

  assert {
    condition     = module.terraform-tfe-variable-sets[0].variable_set[0].name == "tftest-project-varset"
    error_message = "Variable set name should be 'tftest-project-varset'"
  }

}

# ============================================================================
# INTEGRATION TEST 4: Team Creation and Access Configuration
# ============================================================================
# Tests that teams are created with correct names and access levels
# Validates both default and custom team access configurations

run "team_creation_and_access" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
    business_unit        = "" # Empty string means no prefix beyond underscore
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

  command = apply

  # Validate default team creation
  assert {
    condition     = tfe_team.this["team1"].name == "_team1"
    error_message = "Default team name should be '_team1' (underscore prefix with no business unit)"
  }

  assert {
    condition     = tfe_team.this["team1"].organization == "hashi-demos-apj"
    error_message = "Team should belong to organization 'hashi-demos-apj'"
  }

  # Validate custom team creation
  assert {
    condition     = tfe_team.custom["team2"].name == "_team2"
    error_message = "Custom team name should be '_team2' (underscore prefix with no business unit)"
  }

  assert {
    condition     = tfe_team.custom["team2"].organization == "hashi-demos-apj"
    error_message = "Custom team should belong to organization 'hashi-demos-apj'"
  }

  # Validate default team project access
  assert {
    condition     = tfe_team_project_access.default["team1"].access == "read"
    error_message = "Default team should have 'read' access level"
  }

  assert {
    condition     = tfe_team_project_access.default["team1"].team_id == tfe_team.this["team1"].id
    error_message = "Team project access should reference the correct team ID"
  }

  assert {
    condition     = tfe_team_project_access.default["team1"].project_id == tfe_project.consumer.id
    error_message = "Team project access should reference the correct project ID"
  }

  # Validate custom team project access
  assert {
    condition     = tfe_team_project_access.custom["team2"].access == "custom"
    error_message = "Custom team should have 'custom' access level"
  }

  assert {
    condition     = tfe_team_project_access.custom["team2"].team_id == tfe_team.custom["team2"].id
    error_message = "Custom team project access should reference the correct team ID"
  }

  assert {
    condition     = tfe_team_project_access.custom["team2"].project_id == tfe_project.consumer.id
    error_message = "Custom team project access should reference the correct project ID"
  }
}
