provider "aws" {
  region = "eu-west-1"
}


module "ecr" {
  source               = "./../"
  name                 = "ecr"
  application          = "clouddrove"
  environment          = "test"
  label_order          = ["environment", "application", "name"]
  scan_on_push         = true
  image_tag_mutability = "MUTABLE"

}