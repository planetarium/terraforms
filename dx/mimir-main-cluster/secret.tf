resource "aws_secretsmanager_secret" "db_password" {
  name = "${local.kebab_case_prefix}-docdb"

  tags = {
    Name = "${local.kebab_case_prefix}-docdb"
  }
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({ password = data.aws_secretsmanager_random_password.db_password.random_password })

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

data "aws_secretsmanager_random_password" "db_password" {
  password_length     = 16
  exclude_numbers     = true
  exclude_punctuation = true
}
