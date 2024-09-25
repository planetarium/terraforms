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
      },
    ]
  })
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${local.kebab_case_prefix}-ecs-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ec2.amazonaws.com",
      },
      Effect = "Allow",
    }],
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

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_logs_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
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
          aws_secretsmanager_secret.secret.arn,
          var.repository_credentials,
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_logs_policy" {
  name        = "${local.kebab_case_prefix}-ecs-logs-policy"
  description = "Allow ECS tasks to push logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*",
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${local.kebab_case_prefix}-ecs-instance-profile"
  path = "/ecs/instance/"
  role = aws_iam_role.ecs_instance_role.name
}
