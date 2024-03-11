resource "aws_secretsmanager_secret" "secret" {
  name        = "${var.cluster_name}-ninecub/credentials"
  description = "NineChroniclesUtilBackend credentials"
}
