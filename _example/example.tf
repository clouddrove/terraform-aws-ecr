provider "aws" {
  region = "eu-west-2"
}


module "ecr" {
  source = "./../"

  name                         = "ecr"
  environment                  = "test"
  label_order                  = ["environment", "name"]
  scan_on_push                 = true
  max_image_count              = 7
  image_tag_mutability         = "IMMUTABLE"
  image_scanning_configuration = {}

}
