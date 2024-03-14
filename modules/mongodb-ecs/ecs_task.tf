resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "mongo-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = data.template_file.container_definition.rendered

  volume {
    name = "mongo_data"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.efs.id
      root_directory     = "/"
      transit_encryption = "ENABLED"
    }
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/container-definitions/mongodb.tpl")

  vars = {
    cpu                 = var.cpu
    memory              = var.memory
    container_name      = var.service_name
    username_secret_arn = "${aws_secretsmanager_secret.secret.arn}:username::"
    password_secret_arn = "${aws_secretsmanager_secret.secret.arn}:password::"
  }
}
