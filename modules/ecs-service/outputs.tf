output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.service.id
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.service.name
}

output "service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.service.arn
}
