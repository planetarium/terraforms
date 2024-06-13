resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${local.kebab_case_prefix}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/container-definitions/mimir-worker.tpl", {
    image                        = var.image_tag
    cpu                          = var.cpu
    memory                       = var.memory
    container_name               = local.kebab_case_prefix
    log_group_name               = aws_cloudwatch_log_group.log_group.name
    aws_region                   = var.region
    mongodb_db_connection_string = "${aws_secretsmanager_secret.secret.arn}:mongodb_db_connection_string::"
    mongodb_dbname               = "${aws_secretsmanager_secret.secret.arn}:mongodb_dbname::"
    jwt_headless_endpoint        = "${aws_secretsmanager_secret.secret.arn}:jwt_headless_endpoint::"
    sentry_dsn                   = "${aws_secretsmanager_secret.secret.arn}:sentry_dsn::"
    jwt_secrets                  = local.jwt_secrets
  })
}

locals {
  jwt_secrets = var.use_jwt ? [
    {
      name      = "WORKER_Configuration__JwtSecretKey",
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:jwt_secret_key::"
    },
    {
      name      = "WORKER_Configuration__JwtIssuer",
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:jwt_issuer::"
    }
  ] : []
}
