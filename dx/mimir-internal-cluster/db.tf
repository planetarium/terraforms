resource "aws_docdb_subnet_group" "docdb" {
  name       = "${local.kebab_case_prefix}-docdb-subnet-group"
  subnet_ids = local.private_subnet_ids

  tags = {
    Name = "${local.kebab_case_prefix}-docdb-subnet-group"
  }
}

resource "aws_security_group" "docdb" {
  vpc_id = local.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.kebab_case_prefix}-docdb-sg"
  }
}

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier     = "${local.kebab_case_prefix}-docdb-cluster"
  engine                 = "docdb"
  master_username        = var.db_username
  master_password        = jsondecode(aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  db_subnet_group_name   = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.docdb.id]

  tags = {
    Name = "${local.kebab_case_prefix}-docdb-cluster"
  }
}

resource "aws_docdb_cluster_instance" "docdb_instance" {
  count              = 1
  identifier         = "${local.kebab_case_prefix}-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.r6g.large"

  tags = {
    Name = "${local.kebab_case_prefix}-docdb-instance-${count.index}"
  }
}
