resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${local.kebab_case_prefix}-task"
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

  container_definitions = templatefile("${path.module}/container-definitions/mimir-worker.tpl", {
    image                  = var.image_tag
    repository_credentials = var.repository_credentials
    cpu                    = var.cpu
    memory                 = var.memory
    container_name         = local.kebab_case_prefix
    log_group_name         = aws_cloudwatch_log_group.log_group.name
    aws_region             = var.region
    headless_endpoints     = var.headless_endpoints
    planet_type            = var.planet_type
    poller_type            = var.poller_type
    secrets                = local.secrets
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
  mongodb_secrets = [
    {
      name      = "WORKER_Configuration__MongoDbConnectionString"
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:mongodb_db_connection_string::"
    }
  ]
  sentry_secrets = var.use_sentry ? [
    {
      name      = "Sentry__Dsn",
      valueFrom = "${aws_secretsmanager_secret.secret.arn}:sentry_dsn::"
    }
  ] : []
  secrets = concat(local.jwt_secrets, local.mongodb_secrets, local.sentry_secrets)
}
