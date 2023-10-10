## Variables file

variable "project_name" {
  type = string
}

variable "organization_name" {
  type = string
}
variable "team_name" {
  type = string
}

variable "team_project_access" {
  type        = map(string)
  description = "Map of existing Team(s) and built-in permissions to grant on Workspace."
  default     = {}
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
