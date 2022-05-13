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
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "anmol@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove' "
}

variable "attributes" {
  type        = list(any)
  default     = ["environment", "name"]
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

variable "enabled_ecr" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "max_image_count" {
  type        = number
  default     = 7
  description = "How many Docker Image versions AWS ECR will store."
}

variable "principals_readonly_access" {
  type        = list(any)
  default     = []
  description = "Principal ARN to provide with readonly access to the ECR."
}

variable "use_fullname" {
  type        = bool
  default     = true
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

variable "encryption_configuration" {
  type = object({
    encryption_type = string
    kms_key         = any
  })
  description = "ECR encryption configuration"
  default     = null
}

# Image scanning configuration
variable "image_scanning_configuration" {
  type        = map
  default     = {}
   description = "Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. See the ECR User Guide for more information about image scanning."
}

# Timeouts
variable "timeouts" {
  type        = map
  default     = {}
  description = "Timeouts map."
}
