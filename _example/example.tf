provider "aws" {
  region = "us-east-1"
}


module "ecr" {
  source       = "./../"
  name         = "outline"
  environment  = "staging"
  label_order  = ["environment", "name"]
  scan_on_push = true

}
