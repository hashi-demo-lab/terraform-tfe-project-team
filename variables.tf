## Variables file

variable "project_name" {
  type = string
}

variable "organization_name" {
  type = string
}

variable "team_project_access" {
  type = map(
    object({
      team = object({
        access      = optional(string, "read")
        team_sso_id = optional(string, null)
      })
  })
  )
}

variable "custom_team_project_access" {
  type = map(
    object({
      project_access = object({
        settings = optional(string, "read")
        teams    = optional(string, "none")
      })
      workspace_access = object({
        runs           = optional(string, "read")
        sentinel_mocks = optional(string, "none")
        state_versions = optional(string, "none")
        variables      = optional(string, "none")
        create         = optional(bool, false)
        locking        = optional(bool, false)
        delete         = optional(bool, false)
        move           = optional(bool, false)
        run_tasks      = optional(bool, false)

      })
    })
  )
}

variable "create_variable_set" {
  type    = bool
  default = false
}

variable "varset" {
  type = object({
    variables                = optional(map(any), {})
    variable_set_name        = optional(string)
    variable_set_description = optional(string, "")
    tags                     = optional(list(string), [])
    global                   = optional(bool, false)
  })

  validation {
    condition     = try(var.varset.variable_set_name != null, true) ? try(var.varset.variable_set_name != "", true) : true
    error_message = "variable_set_name cannot be an empty string if provided."
  }
}


