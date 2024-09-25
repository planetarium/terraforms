resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${local.kebab_case_prefix}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "secret_read_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.secret_read_policy.arn
}

resource "aws_iam_policy" "secret_read_policy" {
  name        = "${local.kebab_case_prefix}-ecs-secret-read-policy"
  description = "A policy that allows ECS tasks to read secrets from AWS Secret Manager."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "secretsmanager:GetSecretValue",
        Effect = "Allow",
        Resource = [
          var.repository_credentials,
        ]
      }
    ]
  })
}
