## Managed By : CloudDrove
## Description : This Script is used to create Aws ECR repository and policy.
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
  version = "0.15.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

# Module      : ECR  REPOSITORY
# Description : Provides an Elastic Container Registry Repository.
#tfsec:ignore:aws-ecr-enable-image-scans
resource "aws_ecr_repository" "default" {
  count                = var.enabled_ecr ? 1 : 0
  name                 = module.labels.id
  tags                 = module.labels.tags
  image_tag_mutability = var.image_tag_mutability

  dynamic "encryption_configuration" {
    for_each = var.encryption_configuration != null ? [var.encryption_configuration] : []
    content {
      encryption_type = lookup(encryption_configuration.value.encryption_type, null)
      kms_key         = lookup(encryption_configuration.value.kms_key, null)
    }
  }
   dynamic "image_scanning_configuration" {
    for_each = var.image_scanning_configuration
     content {
      scan_on_push = lookup(image_scanning_configuration.value.scan_on_push, null)
  }
  }
   dynamic "timeouts" {
    for_each = var.timeouts
    content {
      delete = lookup(timeouts.value.delete, null)
    }
  }
}

resource "aws_ecr_lifecycle_policy" "default" {
  count      = var.enabled_ecr ? 1 : 0
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
        "countNumber": 1
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

data "aws_iam_policy_document" "empty" {
}

data "aws_iam_policy_document" "resource_readonly_access" {
  statement {
    sid    = "ReadonlyAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_readonly_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
    ]
  }
}

data "aws_iam_policy_document" "resource_full_access" {
  statement {
    sid    = "FullAccess"
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = var.principals_full_access
    }

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
    ]
  }
}


data "aws_iam_policy_document" "resource" {
  source_json   = local.principals_readonly_access_non_empty ? join("", data.aws_iam_policy_document.resource_readonly_access.*.json) : join("", data.aws_iam_policy_document.empty.*.json)
  override_json = local.principals_full_access_non_empty ? join("", data.aws_iam_policy_document.resource_full_access.*.json) : join("", data.aws_iam_policy_document.empty.*.json)
}

# Module      : ECR  REPOSITORY
# Description : Provides an Elastic Container Registry Repository Policy.
resource "aws_ecr_repository_policy" "default" {
  count      = local.ecr_need_policy && var.enabled_ecr ? 1 : 0
  repository = join("", aws_ecr_repository.default.*.name)
  policy     = join("", data.aws_iam_policy_document.resource.*.json)
}
