## Managed By : CloudDrove
## Description : This Script is used to create AWS Public and Private ECR repository and corressponding IAM Policy.
## Copyright @ CloudDrove. All Right Reserved.

locals {
  principals_readonly_access_non_empty = length(var.principals_readonly_access) > 0 ? true : false
  principals_full_access_non_empty     = length(var.principals_full_access) > 0 ? true : false
  ecr_need_policy                      = length(var.principals_full_access) + length(var.principals_readonly_access) > 0 ? true : false
}

#Module      : label
#Description : This terraform module is designed to generate consistent label names and
#              tags for resources. You can use terraform-labels to implement a strict
#              naming convention.
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  attributes  = var.attributes
  delimiter   = var.delimiter
  extra_tags  = var.tags
}

# Module      : ECR  REPOSITORY
# Description : Provides an Elastic Container Registry Repository.
#tfsec:ignore:aws-ecr-enable-image-scans

################################################################################
# Private Repository
################################################################################
resource "aws_ecr_repository" "default" {
  count                = var.enable_private_ecr ? 1 : 0
  name                 = var.use_fullname != "" ? var.use_fullname : module.labels.id
  tags                 = module.labels.tags
  image_tag_mutability = var.image_tag_mutability
  force_delete         = var.repository_force_delete

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  dynamic "timeouts" {
    for_each = var.timeouts
    content {
      delete = lookup(timeouts.value.delete, null)
    }
  }
}

resource "aws_ecr_lifecycle_policy" "private" {
  count      = var.enable_private_ecr ? 1 : 0
  repository = join("", aws_ecr_repository.default.*.name)

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.max_untagged_image_count}
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Rotate images when reach ${var.max_image_count} images stored",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.max_image_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

################################################################################
# Public Repository
################################################################################
resource "aws_ecrpublic_repository" "default" {
  count = var.enable_public_ecr ? 1 : 0

  repository_name = var.use_fullname != "" ? var.use_fullname : module.labels.id

  dynamic "catalog_data" {
    for_each = length(var.public_repository_catalog_data) > 0 ? [var.public_repository_catalog_data] : []

    content {
      about_text        = try(catalog_data.value.about_text, null)
      architectures     = try(catalog_data.value.architectures, null)
      description       = try(catalog_data.value.description, null)
      logo_image_blob   = try(catalog_data.value.logo_image_blob, null)
      operating_systems = try(catalog_data.value.operating_systems, null)
      usage_text        = try(catalog_data.value.usage_text, null)
    }
  }
  tags = module.labels.tags
}

################################################################################
# Private ECR IAM Policies
################################################################################
data "aws_iam_policy_document" "resource_readonly_access_private" {
  statement {
    sid    = "ReadonlyAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_readonly_access
    }

    actions = [
      "ecr:GetRegistryPolicy",
      "ecr:DescribeImageScanFindings",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetDownloadUrlForLayer",
      "ecr:DescribeRegistry",
      "ecr:DescribePullThroughCacheRules",
      "ecr:DescribeImageReplicationStatus",
      "ecr:GetAuthorizationToken",
      "ecr:ListTagsForResource",
      "ecr:ListImages",
      "ecr:BatchGetRepositoryScanningConfiguration",
      "ecr:GetRegistryScanningConfiguration",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:GetLifecyclePolicy",
    ]
  }
}

data "aws_iam_policy_document" "resource_full_access_private" {
  statement {
    sid    = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }

    actions = [
      "ecr:*"
    ]
  }
}

data "aws_iam_policy_document" "resource_private" {
  source_policy_documents   = [local.principals_readonly_access_non_empty ? join("", data.aws_iam_policy_document.resource_readonly_access_private.*.json) : join("", data.aws_iam_policy_document.empty.*.json)]
  override_policy_documents = [local.principals_full_access_non_empty ? join("", data.aws_iam_policy_document.resource_full_access_private.*.json) : join("", data.aws_iam_policy_document.empty.*.json)]
}

resource "aws_ecr_repository_policy" "private" {
  count      = local.ecr_need_policy && var.enable_private_ecr ? 1 : 0
  repository = join("", aws_ecr_repository.default.*.name)
  policy     = join("", data.aws_iam_policy_document.resource_private.*.json)
}

################################################################################
# Public ECR IAM Policies
################################################################################
data "aws_iam_policy_document" "resource_readonly_access_public" {
  statement {
    sid    = "ReadonlyAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_readonly_access
    }

    actions = [
      "ecr-public:DescribeImageTags",
      "ecr-public:DescribeImages",
      "ecr-public:DescribeRepositories",
      "ecr-public:GetAuthorizationToken",
      "ecr-public:DescribeRegistries",
      "ecr-public:GetRepositoryCatalogData",
      "ecr-public:GetRegistryCatalogData",
      "ecr-public:ListTagsForResource",
      "ecr-public:GetRepositoryPolicy",
      "ecr-public:BatchCheckLayerAvailability",
    ]
  }
}

data "aws_iam_policy_document" "resource_full_access_public" {
  statement {
    sid    = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }

    actions = [
      "ecr-public:*"
    ]
  }
}


data "aws_iam_policy_document" "resource_public" {
  source_policy_documents   = [local.principals_readonly_access_non_empty ? join("", data.aws_iam_policy_document.resource_readonly_access_public.*.json) : join("", data.aws_iam_policy_document.empty.*.json)]
  override_policy_documents = [local.principals_full_access_non_empty ? join("", data.aws_iam_policy_document.resource_full_access_public.*.json) : join("", data.aws_iam_policy_document.empty.*.json)]
}

resource "aws_ecr_repository_policy" "public" {
  count      = local.ecr_need_policy && var.enable_public_ecr ? 1 : 0
  repository = join("", aws_ecrpublic_repository.default.*.name)
  policy     = join("", data.aws_iam_policy_document.resource_public.*.json)
}

data "aws_iam_policy_document" "empty" {}