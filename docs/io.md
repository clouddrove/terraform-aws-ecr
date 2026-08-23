## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| enable\_private\_ecr | Controls whether private Amazon ECR repositories are created. Set to true to enable creation of private ECR resources, or false to disable them. | `bool` | `true` | no |
| enable\_public\_ecr | Controls creation of public Amazon ECR repositories. Set to true to enable public ECR. Ensure enable\_private\_ecr is false to avoid conflicts | `bool` | `false` | no |
| encryption\_type | The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256` | `string` | `"KMS"` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `"test"` | no |
| image\_tag\_mutability | The tag mutability setting for the repository. | `string` | `"IMMUTABLE"` | no |
| kms\_key | The ARN of the KMS key to use when encryption\_type is `KMS`. If not specified, uses the default AWS managed key for ECR | `string` | `null` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| lifecycle\_policy | Complete ECR lifecycle policy as JSON. When set it replaces the generated<br>policy entirely, and max\_image\_count and max\_untagged\_image\_count are<br>ignored.<br><br>The generated policy expires by image COUNT, which suits a consumer that<br>pulls by tag: a Kubernetes rollout re-resolves the tag, so an image rotating<br>out harms nothing. It is wrong for a consumer that pins a DIGEST, such as a<br>Lambda function or an admission controller that resolves tags at deploy<br>time. Those stay on one exact image until redeployed, so enough newer pushes<br>will delete the image still in use, and the failure appears later on a cold<br>start with nothing connecting it to the push that caused it.<br><br>ECR supports sinceImagePushed and tagPrefixList selections that express this<br>correctly; neither is reachable through the two count inputs. | `string` | `null` | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"anmol@clouddrove.com"` | no |
| max\_image\_count | How many Docker Image versions AWS ECR will store. | `number` | `10` | no |
| max\_untagged\_image\_count | How many Untagged Docker Image versions AWS ECR will store. | `number` | `1` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| principals\_full\_access | Principal ARN to provide with full access to the ECR. | `list(any)` | `[]` | no |
| principals\_readonly\_access | Principal ARN to provide with readonly access to the ECR. | `list(any)` | `[]` | no |
| public\_repository\_catalog\_data | Catalog data configuration for the repository | `any` | `{}` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-ecr"` | no |
| repository\_force\_delete | If `true`, will delete the repository even if it contains images. Defaults to `false` | `bool` | `true` | no |
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

