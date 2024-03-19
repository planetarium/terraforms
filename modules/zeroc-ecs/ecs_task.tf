resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "zeroc-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }

  volume {
    name      = "${var.service_name}-volume"
    host_path = "/${var.service_name}-chain"
  }

  container_definitions = templatefile("${path.module}/container-definitions/zeroc.tpl", {
    image          = var.image_tag
    cpu            = var.cpu
    memory         = var.memory
    container_name = var.service_name
    cluster_name   = var.cluster_name
    log_group_name = aws_cloudwatch_log_group.log_group.name
    environment    = var.environment
    aws_region     = var.region
  })
}
