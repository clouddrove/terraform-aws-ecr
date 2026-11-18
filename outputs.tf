#Module      : ECR
#Description : This terraform module is used to create ECR on AWS.

output "registry_id" {
  value       = try(aws_ecr_repository.default[0].registry_id, aws_ecrpublic_repository.default[0].registry_id, null)
  description = "Registry ID."
}

output "registry_url" {
  value       = try(aws_ecr_repository.default[0].repository_url, aws_ecrpublic_repository.default[0].repository_uri, null)
  description = "Registry URL."
}

output "repository_name" {
  value       = join("", aws_ecr_repository.default[*].name)
  description = "Registry name."
}

output "arn" {
  value       = try(aws_ecr_repository.default[0].arn, aws_ecrpublic_repository.default[0].arn, null)
  description = "Registry ARN."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}

output "pull_through_cache_rule_ids" {
  value       = { for k, rule in aws_ecr_pull_through_cache_rule.default : k => rule.id }
  description = "Map of created pull-through cache rule IDs."
}

output "replication_registry_id" {
  value       = try(aws_ecr_replication_configuration.default[0].registry_id, null)
  description = "The registry ID where replication configuration is applied."
}
