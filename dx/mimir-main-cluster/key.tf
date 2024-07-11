resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${local.kebab_case_prefix}-key"
  public_key = tls_private_key.private_key.public_key_openssh
}
