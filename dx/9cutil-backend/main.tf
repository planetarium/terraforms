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

  cpu                         = 512
  memory                      = 1024
  vpc_id                      = var.vpc_id
  name                        = "mongodb-ecs-service"
  cluster_name                = var.cluster_name
  desired_count               = 1
  subnets                     = var.subnets
}
