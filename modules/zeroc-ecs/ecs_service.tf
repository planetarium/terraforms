resource "aws_ecs_service" "ecs_service" {
  name    = "${local.kebab_case_prefix}-ecs-service"
  cluster = var.cluster_id

  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = var.desired_count

  health_check_grace_period_seconds = 300

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:custom-attribute == instance-for-zeroc"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.service_name
    container_port   = 80
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.sg.id]
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }
}
