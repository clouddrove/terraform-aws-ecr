<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS ECR
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    This terraform module is used to create ECR on AWS.
     </p>

<p align="center">

<a href="https://github.com/clouddrove/terraform-aws-subnet/releases/latest">
  <img src="https://img.shields.io/github/release/clouddrove/terraform-aws-subnet.svg" alt="Latest Release">
</a>
<a href="https://github.com/clouddrove/terraform-aws-subnet/actions/workflows/tfsec.yml">
  <img src="https://github.com/clouddrove/terraform-aws-subnet/actions/workflows/tfsec.yml/badge.svg" alt="tfsec">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-ecr'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+ECR&url=https://github.com/clouddrove/terraform-aws-ecr'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+ECR&url=https://github.com/clouddrove/terraform-aws-ecr'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure. 

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies: 
- [Terraform 1.5.4](https://learn.hashicorp.com/terraform/getting-started/install.html)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-ecr/releases).


Here are examples of how you can use this module in your inventory structure:
### Private ECR
```hcl
  module "privat_-ecr" {
    source               = "clouddrove/ecr/aws"
    version              = "1.3.0"
    enable_private_ecr   = true
    name                 = "private-ecr"
    environment          = "test"
    scan_on_push         = true
    max_image_count      = 7
}
```
### Public ECR
```hcl
  module "public_ecr" {
    source                   = "clouddrove/ecr/aws"
    version                  = "1.3.0"
    enable_public_ecr        = true
    name                     = "public-ecr"
    environment              = "test"
    max_untagged_image_count = 1
    max_image_count          = 7
    public_repository_catalog_data = {
    description       = "Docker container for some things"
    operating_systems = ["Linux"]
    architectures     = ["x86"]
    }
  }
```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`). | `list(any)` | <pre>[<br>  "environment",<br>  "name"<br>]</pre> | no |
| delimiter | Delimiter to be used between `organization`, `environment`, `name` and `attributes`. | `string` | `"-"` | no |
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




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system. 

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback 
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-ecr/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-ecr)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
