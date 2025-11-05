## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >= 0.49.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.49.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-tfe-variable-sets"></a> [terraform-tfe-variable-sets](#module\_terraform-tfe-variable-sets) | github.com/hashi-demo-lab/terraform-tfe-variable-sets | v0.4.1 |

## Resources

| Name | Type |
|------|------|
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_project_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project_variable_set) | resource |
| [tfe_team.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_team_project_access.bu-control](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_team_project_access.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_team_project_access.default](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_project_access) | resource |
| [tfe_team_token.bu-control-admins](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bu_control_admins_id"></a> [bu\_control\_admins\_id](#input\_bu\_control\_admins\_id) | team id for bu control team sued for project access | `string` | n/a | yes |
| <a name="input_create_variable_set"></a> [create\_variable\_set](#input\_create\_variable\_set) | n/a | `bool` | `false` | no |
| <a name="input_custom_team_project_access"></a> [custom\_team\_project\_access](#input\_custom\_team\_project\_access) | n/a | <pre>map(<br>    object({<br>      team = object({<br>        access      = optional(string, "custom")<br>        team_sso_id = optional(string, "null")<br>      })<br>      project_access = object({<br>        settings = optional(string, "read")<br>        teams    = optional(string, "none")<br>      })<br>      workspace_access = object({<br>        runs           = optional(string, "read")<br>        sentinel_mocks = optional(string, "none")<br>        state_versions = optional(string, "none")<br>        variables      = optional(string, "none")<br>        create         = optional(bool, false)<br>        locking        = optional(bool, false)<br>        delete         = optional(bool, false)<br>        move           = optional(bool, false)<br>        run_tasks      = optional(bool, false)<br><br>      })<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_team_project_access"></a> [team\_project\_access](#input\_team\_project\_access) | n/a | <pre>map(<br>    object({<br>      team = object({<br>        access      = optional(string, "read")<br>        team_sso_id = optional(string, null)<br>      })<br>    })<br>  )</pre> | n/a | yes |
| <a name="input_varset"></a> [varset](#input\_varset) | n/a | <pre>object({<br>    variables                = optional(map(any), {})<br>    variable_set_name        = optional(string)<br>    variable_set_description = optional(string, "")<br>    tags                     = optional(list(string), [])<br>    global                   = optional(bool, false)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project"></a> [project](#output\_project) | tfe project |
| <a name="output_team"></a> [team](#output\_team) | tfe teams pre-defined rbac |
| <a name="output_team_custom"></a> [team\_custom](#output\_team\_custom) | tfe teams custom rbac |


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | 0.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.70.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-tfe-variable-sets"></a> [terraform-tfe-variable-sets](#module\_terraform-tfe-variable-sets) | github.com/hashi-demo-lab/terraform-tfe-variable-sets | v0.4.1 |

## Resources

| Name | Type |
|------|------|
| [tfe_project.consumer](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/project) | resource |
| [tfe_project_variable_set.project](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/project_variable_set) | resource |
| [tfe_team.custom](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/team) | resource |
| [tfe_team.this](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/team) | resource |
| [tfe_team_project_access.bu-control](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/team_project_access) | resource |
| [tfe_team_project_access.custom](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/team_project_access) | resource |
| [tfe_team_project_access.default](https://registry.terraform.io/providers/hashicorp/tfe/0.70.0/docs/resources/team_project_access) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bu_control_admins_access"></a> [bu\_control\_admins\_access](#input\_bu\_control\_admins\_access) | n/a | `string` | `"maintain"` | no |
| <a name="input_bu_control_admins_id"></a> [bu\_control\_admins\_id](#input\_bu\_control\_admins\_id) | team id for bu control team used for admin project access | `string` | n/a | yes |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `""` | no |
| <a name="input_create_variable_set"></a> [create\_variable\_set](#input\_create\_variable\_set) | n/a | `bool` | `false` | no |
| <a name="input_custom_team_project_access"></a> [custom\_team\_project\_access](#input\_custom\_team\_project\_access) | n/a | <pre>map(<br/>    object({<br/>      team = object({<br/>        access      = optional(string, "custom")<br/>        team_sso_id = optional(string, "null")<br/>      })<br/>      project_access = object({<br/>        settings = optional(string, "read")<br/>        teams    = optional(string, "none")<br/>      })<br/>      workspace_access = object({<br/>        runs           = optional(string, "read")<br/>        sentinel_mocks = optional(string, "none")<br/>        state_versions = optional(string, "none")<br/>        variables      = optional(string, "none")<br/>        create         = optional(bool, false)<br/>        locking        = optional(bool, false)<br/>        delete         = optional(bool, false)<br/>        move           = optional(bool, false)<br/>        run_tasks      = optional(bool, false)<br/><br/>      })<br/>    })<br/>  )</pre> | `{}` | no |
| <a name="input_enable_oidc"></a> [enable\_oidc](#input\_enable\_oidc) | n/a | `string` | `false` | no |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | n/a | `string` | n/a | yes |
| <a name="input_project_description"></a> [project\_description](#input\_project\_description) | n/a | `string` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_team_project_access"></a> [team\_project\_access](#input\_team\_project\_access) | n/a | <pre>map(<br/>    object({<br/>      team = object({<br/>        access      = optional(string, "read")<br/>        team_sso_id = optional(string, null)<br/>      })<br/>    })<br/>  )</pre> | n/a | yes |
| <a name="input_varset"></a> [varset](#input\_varset) | n/a | <pre>object({<br/>    variables                = optional(map(any), {})<br/>    variable_set_name        = optional(string)<br/>    variable_set_description = optional(string, "")<br/>    tags                     = optional(list(string), [])<br/>    global                   = optional(bool, false)<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bu"></a> [bu](#output\_bu) | tfe project |
| <a name="output_enable_oidc"></a> [enable\_oidc](#output\_enable\_oidc) | enable oidc |
| <a name="output_name"></a> [name](#output\_name) | tfe project name |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | tfe project |
| <a name="output_project_map"></a> [project\_map](#output\_project\_map) | tfe project map |
| <a name="output_project_name"></a> [project\_name](#output\_project\_name) | tfe project |
| <a name="output_team"></a> [team](#output\_team) | tfe teams pre-defined rbac |
| <a name="output_team_custom"></a> [team\_custom](#output\_team\_custom) | tfe teams custom rbac |
<!-- END_TF_DOCS -->
