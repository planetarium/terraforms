resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ncboard-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/container-definitions/ncboard.tpl", {
    repository_credentials = var.repository_credentials
  })
}
