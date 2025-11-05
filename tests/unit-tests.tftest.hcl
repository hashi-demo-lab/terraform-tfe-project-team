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

provider "tfe" {
  organization = "hashi-demos-apj"
}

# Test fixture setup
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

# Negative test: Validation should reject empty variable_set_name
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
    error_message = "Project name doesn't match expected value"
  }
}

# Positive test: Valid configuration with variable set should succeed
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
    error_message = "Project name doesn't match expected value"
  }

  assert {
    condition     = length(module.terraform-tfe-variable-sets) == 1
    error_message = "Variable set module should be created when create_variable_set is true"
  }
}

# Positive test: Valid configuration without variable set should succeed
run "test_valid_project_without_varset" {
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id

    create_variable_set = false
    varset              = {}
  }

  command = plan

  assert {
    condition     = tfe_project.consumer.name == "tftest-project-testadmin"
    error_message = "Project name doesn't match expected value"
  }

  assert {
    condition     = length(module.terraform-tfe-variable-sets) == 0
    error_message = "Variable set module should NOT be created when create_variable_set is false"
  }
}
