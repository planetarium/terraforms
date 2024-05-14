resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${local.kebab_case_prefix}-ecs"
  retention_in_days = 30
}
