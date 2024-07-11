terraform {
  required_providers {
    aws = {
      version = ">= 3"
    }
  }
  required_version = ">= 1.8.3"

  backend "s3" {
    bucket = "9c-tfstates"
    key    = "dx"
    region = "us-east-2"
  }
}

# Mimir mainnet

module "mongodb_ecs" {
  source = "../../modules/mongodb-ecs"

  cpu            = 2048
  memory         = 4096
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  desired_count  = 1
  public_subnets = local.public_subnet_ids
  environment    = "prod"
}

# Mimir internal

module "internal_mongodb_ecs" {
  source = "../../modules/mongodb-ecs"

  cpu            = 2048
  memory         = 4096
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  desired_count  = 1
  public_subnets = local.public_subnet_ids
  environment    = "prod"
  service_name   = "internal-mongodb"
}

# module "internal_mimir_ecs" {
#   source = "../../modules/mimir-ecs"

#   cpu            = 2048
#   memory         = 4096
#   vpc_id         = local.vpc_id
#   cluster_id     = aws_ecs_cluster.ecs_cluster.id
#   cluster_name   = var.cluster_name
#   image_tag      = var.mimir_image
#   desired_count  = 1
#   public_subnets = local.public_subnet_ids
#   environment    = "prod"
#   service_name   = "internal-mimir"
#   use_jwt        = false
# }

# module "internal_mimir_worker_heimdall_ecs" {
#   source = "../../modules/mimir-worker-ecs"

#   cpu            = 1024
#   memory         = 2048
#   vpc_id         = local.vpc_id
#   cluster_id     = aws_ecs_cluster.ecs_cluster.id
#   cluster_name   = var.cluster_name
#   image_tag      = var.mimir_worker_image
#   desired_count  = 1
#   public_subnets = local.public_subnet_ids
#   environment    = "prod"
#   network        = "heimdall"
#   service_name   = "internal-mimir-worker"
#   use_jwt        = false
# }

# module "internal_mimir_worker_odin_ecs" {
#   source = "../../modules/mimir-worker-ecs"

#   cpu            = 1024
#   memory         = 2048
#   vpc_id         = local.vpc_id
#   cluster_id     = aws_ecs_cluster.ecs_cluster.id
#   cluster_name   = var.cluster_name
#   image_tag      = var.mimir_worker_image
#   desired_count  = 1
#   public_subnets = local.public_subnet_ids
#   environment    = "prod"
#   network        = "odin"
#   service_name   = "internal-mimir-worker"
#   use_jwt        = false
# }

module "ncboard_ecs" {
  source = "../../modules/ncboard-ecs"

  cpu                   = 1024
  memory                = 2048
  vpc_id                = local.vpc_id
  cluster_id            = aws_ecs_cluster.ecs_cluster.id
  cluster_name          = var.cluster_name
  image_tag             = var.ncboard_image
  desired_count         = 1
  public_subnets        = local.public_subnet_ids
  network_conf_map      = var.network_conf_map
  mimir_graphql_url_map = var.mimir_graphql_url_map
  environment           = "prod"
}
