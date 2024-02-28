resource "aws_ecs_service" "ecs_service" {
  name        = var.name
  cluster     = aws_ecs_cluster.ecs_cluster.id
  launch_type = "FARGATE"

  task_definition      = aws_ecs_task_definition.mongo_task.arn
  force_new_deployment = false
  desired_count        = var.desired_count

  network_configuration {
    assign_public_ip = true
    subnets          = var.subnets
    security_groups  = [aws_security_group.mongo_sg.id]
  }

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100
}
