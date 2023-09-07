provider "aws" {
  region = "us-east-1"
}

locals {
  name        = "private-ecr"
  environment = "test"
}

##-----------------------------------------------------------------------------
## private_ecr module call.
##-----------------------------------------------------------------------------
module "private_ecr" {
  source             = "./../../"
  enable_private_ecr = true
  name               = local.name
  environment        = local.environment
  scan_on_push       = true
  max_image_count    = 7
}
