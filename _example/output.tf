output "arn" {
  value       = module.ecr.*.registry_id
  description = "The ARN suffix of the ALB"
}

output "tags" {
  value       = module.ecr.tags
  description = "A mapping of tags to assign to the alb."
}