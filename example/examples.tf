

module "ecr" {
  source               = "git::https://github.com/clouddrove/terraform-aws-ecr.git"
  name                 = "test"
  organization         = "organization"
  environment          = "environment"
}