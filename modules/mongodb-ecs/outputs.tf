output "mongo_task_definition_arn" {
  description = "The ARN of the MongoDB task definition"
  value       = aws_ecs_task_definition.mongo_task.arn
}

output "mongo_security_group_id" {
  description = "The ID of the MongoDB security group"
  value       = aws_security_group.mongo_sg.id
}

output "efs_file_system_id" {
  description = "The ID of the EFS file system created for MongoDB"
  value       = aws_efs_file_system.mongo_efs.id
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.ecs_service.id
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_service.ecs_cluster.id
}
