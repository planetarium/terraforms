resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ninecubs-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = templatefile("${path.module}/container-definitions/ninec_ubs.tpl", {
    image                        = var.image_tag
    cpu                          = var.cpu
    memory                       = var.memory
    container_name               = var.service_name
    log_group_name               = aws_cloudwatch_log_group.log_group.name
    aws_region                   = var.region
    emptychronicle_base_url      = "${aws_secretsmanager_secret.secret.arn}:emptychronicle_base_url::"
    mongodb_db_connection_string = "${aws_secretsmanager_secret.secret.arn}:mongodb_db_connection_string::"
    mongodb_dbname               = "${aws_secretsmanager_secret.secret.arn}:mongodb_dbname::"
  })
}
