resource "aws_efs_file_system" "mongo_efs" {
  creation_token = "mongo-efs"

  tags = {
    Name = "MongoDBEFS"
  }
}

resource "aws_efs_mount_target" "mongo_efs_mount_target" {
  count           = length(var.subnets)
  file_system_id  = aws_efs_file_system.mongo_efs.id
  subnet_id       = var.subnets[count.index]
  security_groups = [aws_security_group.mongo_efs_sg.id]
}

resource "aws_security_group" "mongo_efs_sg" {
  name        = "mongo_efs_sg"
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
