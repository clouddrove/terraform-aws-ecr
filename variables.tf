#Module      : LABEL
#Description : Terraform label module variables
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}


variable "environment" {
  type        = string
  default     = "test"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' "
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `organization`, `environment`, `name` and `attributes`."
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "enable_private_ecr" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from creating any resources."
}

variable "max_image_count" {
  type        = number
  default     = 10
  description = "How many Docker Image versions AWS ECR will store."
}

variable "max_untagged_image_count" {
  type        = number
  default     = 1
  description = "How many Untagged Docker Image versions AWS ECR will store."
}

variable "principals_readonly_access" {
  type        = list(any)
  default     = []
  description = "Principal ARN to provide with readonly access to the ECR."
}

variable "use_fullname" {
  type        = string
  default     = ""
  description = "Set 'true' to use `namespace-stage-name` for ecr repository name, else `name`."
}

variable "principals_full_access" {
  type        = list(any)
  description = "Principal ARN to provide with full access to the ECR."
  default     = []
}

variable "scan_on_push" {
  type        = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default     = true
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-ecr"
  description = "Terraform current module repo"
}

variable "image_tag_mutability" {
  type        = string
  default     = "IMMUTABLE"
  description = "The tag mutability setting for the repository."
}

variable "repository_force_delete" {
  type        = bool
  default     = false
  description = "If `true`, will delete the repository even if it contains images. Defaults to `false`"
}

variable "encryption_type" {
  type        = string
  default     = "KMS"
  description = "The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256`"
}

variable "kms_key" {
  type        = string
  default     = null
  description = "The ARN of the KMS key to use when encryption_type is `KMS`. If not specified, uses the default AWS managed key for ECR"
}

# Timeouts
variable "timeouts" {
  type        = map(any)
  default     = {}
  description = "Timeouts map."
}

# Public Repository
variable "enable_public_ecr" {
  type        = bool
  default     = false
  description = "Set to false to prevent the module from creating any resources."
}

variable "public_repository_catalog_data" {
  description = "Catalog data configuration for the repository"
  type        = any
  default     = {}
}
