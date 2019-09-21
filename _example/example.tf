provider "aws" {
  region = "eu-west-1"
}

module "ecr" {
  source = "./../"
  name        = "ecr"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name", "application"]

}