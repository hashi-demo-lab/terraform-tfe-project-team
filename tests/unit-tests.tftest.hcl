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
    variable_set_name = ""
  }
  create_variable_set = true

  bu_control_project_name = "test-bu1-project"
  bu_control_workspace = "test-bu1-workspace"
  bu_control_admins_id = ""
}

provider "tfe" {
  organization = "hashi-demos-apj"
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

run "input_validation_varset_noname" {
  # Load and count the objects created in the "execute" run block.
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
    
  }
  command = plan

  expect_failures = [
    var.varset,
  ]

  assert {
    condition     = tfe_project.this.name == "tftest-project-testadmin"
    error_message = "Project names matched - tftest-project-testadmin"
  }

}


run "test11" {
 # Load and count the objects created in the "execute" run block.
  variables {
    bu_control_admins_id = run.setup_bu_control.bu_control_team_id
    
  }

  command = plan

  expect_failures = [
    var.varset,
  ]

  assert {
    condition     = tfe_project.this.name == "tftest-project-testadmin"
    error_message = "Project names matched - tftest-project-testadmin"
  }

}
