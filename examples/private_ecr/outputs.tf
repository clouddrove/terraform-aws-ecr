output "private_ecr_arn" {
  value       = module.private_ecr[*].arn
  description = "Registry name."
}

output "private_ecr_tags" {
  value       = module.private_ecr.tags
  description = "A mapping of tags to assign to the alb."
}

output "private_ecr_registry_id" {
  value       = module.private_ecr.registry_id
  description = "The registry ID where the repository was created."
}

output "private_ecr_registry_url" {
  value       = module.private_ecr.registry_url
  description = "The URL of the repository (in the form."
}
