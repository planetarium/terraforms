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

module "ncboard_ecs" {
  source = "../../modules/ncboard-ecs"

  cpu                    = 1024
  memory                 = 2048
  vpc_id                 = local.vpc_id
  cluster_id             = aws_ecs_cluster.ecs_cluster.id
  cluster_name           = var.cluster_name
  image_tag              = var.ncboard_image
  desired_count          = 1
  public_subnets         = local.public_subnet_ids
  network_conf_map       = var.network_conf_map
  mimir_graphql_url_map  = var.mimir_graphql_url_map
  environment            = "prod"
  repository_credentials = var.repository_credentials
}
