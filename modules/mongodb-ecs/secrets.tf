resource "random_string" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric  = true
}

resource "aws_secretsmanager_secret" "mongodb_secret" {
  name        = "${var.cluster_name}-mongodb/credentials"
  description = "MongoDB credentials"
}

resource "aws_secretsmanager_secret_version" "mongodb_secret_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_secret.id
  secret_string = jsonencode({
    username = "planetarium"
    password = random_string.db_password.result
  })
}
