resource "aws_ecs_task_definition" "zeroc_task" {
  family                   = "zeroc-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = data.template_file.container_definition.rendered

  volume {
    name = "zeroc_data"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.zeroc_efs.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
    }
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/container-definitions/zeroc.tpl")

  vars = {
    image        = var.image
    cpu          = var.cpu
    memory       = var.memory
    cluster_name = var.cluster_name
    environment  = var.environment
    aws_region   = "us-east-2"
  }
}
