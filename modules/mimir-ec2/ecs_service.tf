resource "aws_ecs_service" "ecs_service" {
  name    = "${local.kebab_case_prefix}-service"
  cluster = var.cluster_id

  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.desired_count

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = local.kebab_case_prefix
    container_port   = 8080
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.service_sg.id]
  }

  capacity_provider_strategy {
    capacity_provider = var.ecs_capacity_provider_name
    weight            = 100
  }
}
