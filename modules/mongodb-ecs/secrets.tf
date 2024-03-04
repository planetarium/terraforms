resource "aws_secretsmanager_secret" "mongodb_secret" {
  name        = "${var.cluster_name}-mongodb/credentials"
  description = "MongoDB credentials"
}

resource "aws_secretsmanager_secret_version" "mongodb_secret_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_secret.id
  secret_string = jsonencode({
    username = var.mongodb_username
    password = var.mongodb_password
  })
}
