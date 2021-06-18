provider "aws" {
  region = "eu-west-2"
}


module "ecr" {
  source       = "./../"
  name         = "ecr"
  environment  = "test"
  label_order  = ["environment", "name"]
  scan_on_push = true

}
