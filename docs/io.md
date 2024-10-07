## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enable\_private\_ecr | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| enable\_public\_ecr | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| encryption\_type | The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256` | `string` | `"KMS"` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"test"` | no |
| image\_tag\_mutability | The tag mutability setting for the repository. | `string` | `"IMMUTABLE"` | no |
| kms\_key | The ARN of the KMS key to use when encryption\_type is `KMS`. If not specified, uses the default AWS managed key for ECR | `string` | `null` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"anmol@clouddrove.com"` | no |
| max\_image\_count | How many Docker Image versions AWS ECR will store. | `number` | `10` | no |
| max\_untagged\_image\_count | How many Untagged Docker Image versions AWS ECR will store. | `number` | `1` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| principals\_full\_access | Principal ARN to provide with full access to the ECR. | `list(any)` | `[]` | no |
| principals\_readonly\_access | Principal ARN to provide with readonly access to the ECR. | `list(any)` | `[]` | no |
| public\_repository\_catalog\_data | Catalog data configuration for the repository | `any` | `{}` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-ecr"` | no |
| repository\_force\_delete | If `true`, will delete the repository even if it contains images. Defaults to `false` | `bool` | `false` | no |
| scan\_on\_push | Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false). | `bool` | `true` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| timeouts | Timeouts map. | `map(any)` | `{}` | no |
| use\_fullname | Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Registry ARN. |
| registry\_id | Registry ID. |
| registry\_url | Registry URL. |
| repository\_name | Registry name. |
| tags | A mapping of tags to assign to the resource. |
