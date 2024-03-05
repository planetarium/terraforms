resource "aws_ecs_service" "zeroc_service" {
  name    = "${var.cluster_name}-ecs-service-zeroc-${var.environment}"
  cluster = var.create_cluster ? aws_ecs_cluster.ecs_cluster[0].id : var.cluster_id

  task_definition      = aws_ecs_task_definition.zeroc_task.arn
  desired_count        = var.desired_count
  force_new_deployment = true

  placement_constraints {
    type = "distinctInstance"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.zeroc_tg.arn
    container_name   = "zeroc"
    container_port   = 5009
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.zeroc_sg.id]
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_capacity_provider.name
    weight            = 100
  }

  triggers = {
    redeployment = timestamp()
  }
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  depends_on = [aws_autoscaling_group.zeroc_asg]
}
