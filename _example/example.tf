provider "aws" {
  region = "us-east-1"
}

module "private_ecr" {
  source = "./../"

  enable_private_ecr         = true
  name                       = "private-ecr"
  environment                = "test"
  label_order                = ["environment", "name"]
  scan_on_push               = true
  max_image_count            = 7
  image_tag_mutability       = "IMMUTABLE"
  encryption_type            = "KMS"
}

module "public_ecr" {
  source = "./../"

  enable_public_ecr = true
  name              = "public-ecr"
  environment       = "test"
  label_order       = ["environment", "name"]

  max_untagged_image_count = 1
  max_image_count          = 7

  public_repository_catalog_data = {
    description       = "Docker container for some things"
    operating_systems = ["Linux"]
    architectures     = ["x86"]
  }
}