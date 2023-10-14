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

  platform_project_name = "test_platform_project"
}

provider "tfe" {
  organization = "hashi-demos-apj"
}


run "input validation varset-noname" {
  # Load and count the objects created in the "execute" run block.
  command = plan

  expect_failures = [
    var.varset,
  ]

  assert {
    condition     = tfe_project.this.name == "tftest-project-testadmin"
    error_message = "Project names matched - tftest-project-testadmin"
  }

}
