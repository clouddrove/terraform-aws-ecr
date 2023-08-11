provider "aws" {
  region = "us-east-1"
}


module "public_ecr" {
  source                   = "./../../"
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