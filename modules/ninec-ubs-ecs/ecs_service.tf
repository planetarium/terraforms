resource "aws_ecs_service" "ecs_service" {
  name    = "${var.cluster_name}-ecs-service-ninecubs-${var.environment}"
  cluster = var.create_cluster ? aws_ecs_cluster.ecs_cluster[0].id : var.cluster_id
  launch_type = "FARGATE"

  task_definition      = aws_ecs_task_definition.ecs_task.arn
  desired_count        = var.desired_count

  network_configuration {
    assign_public_ip = true
    subnets         = var.public_subnets
    security_groups = [aws_security_group.sg.id]
  }

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
