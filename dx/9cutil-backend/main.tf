terraform {
  required_providers {
    aws = {
      version = ">= 3"
    }
  }
  required_version = ">= 1.3.6"

  backend "s3" {
    bucket = "9c-tfstates.planetarium.dev"
    key    = "9cutilbackend/dx"
    region = "ap-northeast-2"
  }
}

module "mongodb_ecs" {
  source = "../../modules/mongodb-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  desired_count  = 1
  public_subnets        = aws_subnet.public[*].id
}

module "zeroc_ecs" {
  source = "../../modules/zeroc-ecs"

  cpu            = 4096
  memory         = 31000
  vpc_id         = aws_vpc.main.id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  image_tag          = var.zeroc_image
  instance_type  = "r7g.xlarge"
  desired_count  = 1
  subnets        = aws_subnet.private[*].id
  public_subnets = aws_subnet.public[*].id
}

module "ninec_utilbackend_ecs" {
  source = "../../modules/ninecub-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  image_tag          = var.ninecub_image
  desired_count  = 1
  public_subnets = aws_subnet.public[*].id
}

module "ninec_utilbackend_store_ecs" {
  source = "../../modules/ninecubs-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = aws_vpc.main.id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  image_tag          = var.ninecubs_image
  desired_count  = 1
  public_subnets = aws_subnet.public[*].id
}
