output "arn" {
  value       = module.ecr.*.arn
  description = "Registry name."
}

output "tags" {
  value       = module.ecr.tags
  description = "A mapping of tags to assign to the alb."
}

output "registry_id" {
  value       = module.ecr.registry_id
  description = "The registry ID where the repository was created."
}

output "registry_url" {
  value       = module.ecr.registry_url
  description = "The URL of the repository (in the form."
}