resource "aws_secretsmanager_secret" "secret" {
  name        = "${local.kebab_case_prefix}/credentials"
  description = "Mimir Worker credentials"
}
