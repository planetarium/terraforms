terraform {
  required_providers {
    aws = {
      version = ">= 3"
    }
  }
  required_version = ">= 1.3.6"

  backend "s3" {
    bucket = "9c-tfstates"
    key    = "dx"
    region = "us-east-2"
  }
}

module "mongodb_ecs" {
  source = "../../modules/mongodb-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  desired_count  = 1
  public_subnets = local.public_subnet_ids
}

module "zeroc_ecs" {
  source = "../../modules/zeroc-ecs"

  cpu            = 8192
  memory         = 63400
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  image_tag      = var.zeroc_image
  instance_type  = "r7g.2xlarge"
  desired_count  = 1
  subnets        = local.private_subnet_ids
  public_subnets = local.public_subnet_ids
}

module "ninec_utilbackend_ecs" {
  source = "../../modules/ninecub-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  image_tag      = var.ninecub_image
  desired_count  = 1
  public_subnets = local.public_subnet_ids
}

module "ninec_utilbackend_store_ecs" {
  source = "../../modules/ninecubs-ecs"

  cpu            = 1024
  memory         = 2048
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  image_tag      = var.ninecubs_image
  desired_count  = 1
  public_subnets = local.public_subnet_ids
}
