resource "aws_efs_file_system" "efs" {
  creation_token = "${local.kebab_case_prefix}-efs"

  tags = {
    Name = "MongoDBEFS"
    Team = var.tags.Team
  }
}

resource "aws_efs_mount_target" "efs_mount_target" {
  count           = length(var.public_subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.public_subnets[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_security_group" "efs_sg" {
  name        = "${local.kebab_case_prefix}-efs-sg"
  description = "Security group for MongoDB EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
