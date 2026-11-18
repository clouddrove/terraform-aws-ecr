output "registry_url" {
  value       = module.ecr.registry_url
  description = "The URL of the created private ECR repository."
}

output "pull_through_cache_rule_ids" {
  value       = module.ecr.pull_through_cache_rule_ids
  description = "Map of created pull-through cache rule IDs."
}

output "replication_registry_id" {
  value       = module.ecr.replication_registry_id
  description = "The registry ID where replication configuration is applied."
}
