terraform {
  required_providers {
    aws = {
      version = ">= 3"
    }
  }
  required_version = ">= 1.3.6"

  backend "s3" {
    bucket = "9c-tfstates.planetarium.dev"
    key    = "9cutilbackend/mongodb"
    region = "ap-northeast-2"
  }
}

module "mongodb_ecs" {
  source = "../../modules/mongodb-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_name   = var.cluster_name
  create_cluster = true
  desired_count  = 1
  subnets        = aws_subnet.public[*].id
}

module "zeroc_ecs" {
  source = "../../modules/zeroc-ecs"

  cpu            = 4096
  memory         = 31000
  vpc_id         = aws_vpc.main.id
  cluster_id     = module.mongodb_ecs.ecs_cluster_id
  cluster_name   = var.cluster_name
  image          = "git-475c5b93acd39818796f8aa7ed1cf978626c5b55"
  instance_type  = "r7g.xlarge"
  create_cluster = false
  desired_count  = 1
  subnets        = aws_subnet.private[*].id
  public_subnets = aws_subnet.public[*].id
}

module "ninec_utilbackend_ecs" {
  source = "../../modules/ninec-ub-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_id     = module.mongodb_ecs.ecs_cluster_id
  cluster_name   = var.cluster_name
  image          = "git-d11a2d3f38e3f28d9bfb4f31274ae5b2616fb09e"
  create_cluster = false
  desired_count  = 1
  public_subnets = aws_subnet.public[*].id
}

module "ninec_utilbackend_store_ecs" {
  source = "../../modules/ninec-ubs-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_id     = module.mongodb_ecs.ecs_cluster_id
  cluster_name   = var.cluster_name
  image          = "git-e09438e885052a63a52ced8db1b898ed7f123eb9"
  create_cluster = false
  desired_count  = 1
  public_subnets = aws_subnet.public[*].id
}
