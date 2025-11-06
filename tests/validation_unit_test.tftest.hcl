# ============================================================================
# UNIT TESTS (Plan Mode) - Validate logic without creating real resources
# ============================================================================
# This file contains unit tests using command = plan (fast, no resources created)
# These tests validate input validation, conditional logic, and module behavior

# Default variable values for all run blocks in this file
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

  # Default to invalid config for negative test
  varset = {
    variable_set_name = ""
  }
  create_variable_set = true

  bu_control_project_name = "test-bu1-project"
  bu_control_workspace    = "test-bu1-workspace"
  bu_control_admins_id    = ""
}

# Configure provider for testing
provider "tfe" {
  organization = "hashi-demos-apj"
}

# ============================================================================
# TEST FIXTURE SETUP
# ============================================================================
# This run block creates the BU control infrastructure needed for testing
# Uses apply mode to create real resources that subsequent tests depend on

run "setup_bu_control" {
  variables {
    organization_name       = "hashi-demos-apj"
    bu_control_project_name = "test_platform_project"
    bu_control_workspace    = "test-bu1-workspace"
  }

  command = apply
  module {
    source = "./tests/setup"
  }
}

# ============================================================================
# NEGATIVE TESTS - Input Validation
# ============================================================================
# Test that invalid inputs are properly rejected by validation rules

# Test: Variable set with empty name should be rejected
run "input_validation_varset_noname" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
  }

  command = plan

  expect_failures = [
    var.varset,
  ]

  assert {
    condition     = tfe_project.consumer.name == "tftest-project-testadmin"
    error_message = "Project name should be 'tftest-project-testadmin' even with invalid varset config"
  }
}

# ============================================================================
# POSITIVE TESTS - Valid Configurations
# ============================================================================
# Test that valid configurations produce expected results

# Test: Valid configuration with variable set should succeed
run "test_valid_project_with_varset" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id

    varset = {
      variable_set_name        = "test-varset-valid"
      variable_set_description = "Test variable set"
    }
    create_variable_set = true
  }

  command = plan

  assert {
    condition     = tfe_project.consumer.name == "tftest-project-testadmin"
    error_message = "Project name should be 'tftest-project-testadmin'"
  }

  assert {
    condition     = length(module.terraform-tfe-variable-sets) == 1
    error_message = "Exactly one variable set module should be created when create_variable_set is true"
  }
}

# Test: Valid configuration without variable set should succeed
run "test_valid_project_without_varset" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id

    create_variable_set = false
    varset              = {}
  }

  command = plan

  assert {
    condition     = tfe_project.consumer.name == "tftest-project-testadmin"
    error_message = "Project name should be 'tftest-project-testadmin'"
  }

  assert {
    condition     = length(module.terraform-tfe-variable-sets) == 0
    error_message = "No variable set modules should be created when create_variable_set is false"
  }
}
