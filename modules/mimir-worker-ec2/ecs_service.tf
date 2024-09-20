resource "aws_ecs_service" "ecs_service" {
  name    = "${local.kebab_case_prefix}-ecs-service"
  cluster = var.cluster_id

  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.sg.id]
  }

  capacity_provider_strategy {
    capacity_provider = var.ecs_capacity_provider_name
    weight            = 100
  }
}
