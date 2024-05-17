resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "mimir-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/container-definitions/mimir.tpl", {
    container_name            = var.service_name
    image                     = var.image_tag
    cpu                       = var.cpu
    memory                    = var.memory
    log_group_name            = aws_cloudwatch_log_group.log_group.name
    environment               = var.environment
    aws_region                = var.region
    mongodb_connection_string = "${aws_secretsmanager_secret.secret.arn}:mongodb_connection_string::"
    mongodb_dbname            = "${aws_secretsmanager_secret.secret.arn}:mongodb_dbname::"
    jwt_headless_endpoint     = "${aws_secretsmanager_secret.secret.arn}:jwt_headless_endpoint::"
    jwt_secrets               = local.jwt_secrets
  })
}

locals {
  jwt_secrets = var.use_jwt ? [
    {
      name      = "StateService__JwtSecretKey",
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:jwt_secret_key::"
    },
    {
      name      = "StateService__JwtIssuer",
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:jwt_issuer::"
    }
  ] : []
}
