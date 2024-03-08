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
    name = "chain-volume"
    host_path = "/zeroc-chain"
  }

  container_definitions = data.template_file.container_definition.rendered
}

data "template_file" "container_definition" {
  template = file("${path.module}/container-definitions/zeroc.tpl")

  vars = {
    image        = var.image
    cpu          = var.cpu
    memory       = var.memory
    cluster_name = var.cluster_name
    environment  = var.environment
    aws_region   = var.region
  }
}
