# setup

<!-- BEGIN_TF_DOCS -->
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

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_project.bu-control](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_team.bu-control-admins](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team) | resource |
| [tfe_workspace.bu-control](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bu_control_project_name"></a> [bu\_control\_project\_name](#input\_bu\_control\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_bu_control_workspace"></a> [bu\_control\_workspace](#input\_bu\_control\_workspace) | n/a | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bu_control_project_id"></a> [bu\_control\_project\_id](#output\_bu\_control\_project\_id) | project id for bu control project |
| <a name="output_bu_control_team_id"></a> [bu\_control\_team\_id](#output\_bu\_control\_team\_id) | team id for bu control project team |
<!-- END_TF_DOCS -->
