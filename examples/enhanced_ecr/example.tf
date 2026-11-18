provider "aws" {
  region = "us-east-1"
}

module "ecr" {
  source = "../.."

  name        = "ecr"
  environment = "test"
  label_order = ["name", "environment"]

  # Private Repository Settings
  enable_private_ecr = true
  image_tag_mutability      = "IMMUTABLE"

  # Built-in Lifecycle Policy (Bina JSON likhe)
  enable_default_lifecycle_policy = true
  max_image_count                 = 7
  untagged_image_days             = 7

  # Cross-Region Replication
  enable_replication  = true
  replication_regions = ["ca-central-1"]

  # Registry-Level Enhanced Scanning (AWS Inspector)
  enable_enhanced_scanning = true

  # Pull Through Cache Rules
    pull_through_cache_rules = {
    "ecr-public" = {
      upstream_registry_url = "public.ecr.aws"
    }
    "k8s" = {
      upstream_registry_url = "registry.k8s.io"
    }
  }  
}
