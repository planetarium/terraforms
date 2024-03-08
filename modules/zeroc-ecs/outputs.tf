output "zeroc_task_definition_arn" {
  description = "The ARN of the Zeroc task definition"
  value       = aws_ecs_task_definition.ecs_task.arn
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.ecs_service.id
}
