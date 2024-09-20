resource "random_string" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_secretsmanager_secret" "secret" {
  name        = "${local.kebab_case_prefix}/credentials"
  description = "MongoDB credentials"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode({
    username = "planetarium"
    password = random_string.db_password.result
  })
}
