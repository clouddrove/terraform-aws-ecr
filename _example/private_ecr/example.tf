provider "aws" {
  region = "us-east-1"
}

module "private_ecr" {
  source             = "./../../"
  enable_private_ecr = true
  name               = "private-ecr"
  environment        = "test"
  scan_on_push       = true
  max_image_count    = 7
}