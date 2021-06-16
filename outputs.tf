#Module      : ECR
#Description : This terraform module is used to create ECR on AWS.

output "registry_id" {
  value       = join("", aws_ecr_repository.default.*.registry_id)
  description = "Registry ID."
}

output "registry_url" {
  value       = join("", aws_ecr_repository.default.*.repository_url)
  description = "Registry URL."
}

output "repository_name" {
  value       = join("", aws_ecr_repository.default.*.name)
  description = "Registry name."
}

output "arn" {
  value       = join("", aws_ecr_repository.default.*.arn)
  description = "Registry ARN."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}
