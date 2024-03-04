resource "aws_efs_file_system" "zeroc_efs" {
  creation_token = "zeroc-efs"

  tags = {
    Name = "ZerocEFS"
  }
}

resource "aws_efs_mount_target" "zeroc_efs_mount_target" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.zeroc_efs.id
  subnet_id       = var.subnets[count.index]
  security_groups = [aws_security_group.zeroc_efs_sg.id]
}

resource "aws_security_group" "zeroc_efs_sg" {
  name        = "${var.cluster_name}_zeroc_efs_sg_${var.environment}"
  description = "Security group for Zeroc EFS"
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
