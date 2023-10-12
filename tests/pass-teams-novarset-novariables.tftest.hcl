variables {
  organization_name = "hashi-demos-apj"
  project_name      = "tftest-project-testadmin"

  team_project_access = {
    "tftest-project-testadmin-team-admin" = "admin"
  }

  custom_team_project_access = {}

  varset              = null
  create_variable_set = false

}

provider "tfe" {
  organization = "hashi-demos-apj"
}


run "test" {
  # Load and count the objects created in the "execute" run block.

  command = apply

  assert {
    condition     = tfe_project.this.name == "tftest-project-testadmin"
    error_message = "Project names matched - tftest-project-testadmin"
  }

}