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

  cpu                         = 1024
  memory                      = 2048
  vpc_id                      = var.vpc_id
  cluster_name                = var.cluster_name
  create_cluster              = true
  desired_count               = 1
  subnets                     = var.subnets
  mongodb_username            = var.mongodb_username
  mongodb_password            = var.mongodb_password
}

module "zeroc_ecs" {
  source = "../../modules/zeroc-ecs"

  cpu                         = 2048
  memory                      = 4096
  vpc_id                      = var.vpc_id
  cluster_id                  = module.mongodb_ecs.ecs_cluster_id
  cluster_name                = var.cluster_name
  image                       = "git-bfe575470f0bd5245eed628eaca6b6a11fd99df5"
  create_cluster              = false
  desired_count               = 1
  subnets                     = var.subnets
}
