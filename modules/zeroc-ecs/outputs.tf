output "zeroc_task_definition_arn" {
  description = "The ARN of the Zeroc task definition"
  value       = aws_ecs_task_definition.zeroc_task.arn
}

output "zeroc_security_group_id" {
  description = "The ID of the Zeroc security group"
  value       = aws_security_group.zeroc_sg.id
}

output "efs_file_system_id" {
  description = "The ID of the EFS file system created for Zeroc"
  value       = aws_efs_file_system.zeroc_efs.id
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.ecs_service.id
}
