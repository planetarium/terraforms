resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ncboard-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/container-definitions/ncboard.tpl", {
    container_name   = var.service_name
    image            = var.image_tag
    cpu              = var.cpu
    memory           = var.memory
    log_group_name   = aws_cloudwatch_log_group.log_group.name
    environment      = var.environment
    aws_region       = var.region
    network_conf_map = var.network_conf_map
  })
}
