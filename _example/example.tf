provider "aws" {
  region = "eu-west-1"
}

module "ecr" {
  source      = "git::https://github.com/clouddrove/terraform-aws-ecr.git?ref=tags/0.12.0"
  name        = "ecr"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name", "application"]
}