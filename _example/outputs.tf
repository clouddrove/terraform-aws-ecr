output "arn" {
  value       = module.ecr.*.arn
  description = "Registry name."
}

output "tags" {
  value       = module.ecr.tags
  description = "A mapping of tags to assign to the alb."
}