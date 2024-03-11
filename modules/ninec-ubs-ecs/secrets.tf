resource "aws_secretsmanager_secret" "secret" {
  name        = "${var.cluster_name}-ninecubs/credentials"
  description = "NineChroniclesUtilBackend Store credentials"
}
