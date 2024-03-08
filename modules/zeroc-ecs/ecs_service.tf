resource "aws_ecs_service" "ecs_service" {
  name    = "${var.cluster_name}-ecs-service-zeroc-${var.environment}"
  cluster = var.create_cluster ? aws_ecs_cluster.ecs_cluster[0].id : var.cluster_id

  task_definition      = aws_ecs_task_definition.ecs_task.arn
  desired_count        = var.desired_count

  health_check_grace_period_seconds = 300

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:custom-attribute == instance-for-zeroc"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "zeroc"
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
