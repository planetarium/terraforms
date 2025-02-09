module "mimir_worker_heimdall_diff_ec2" {
  source = "../../modules/mimir-worker-ec2"

  cpu                        = 2048
  memory                     = 1800
  vpc_id                     = local.vpc_id
  cluster_id                 = aws_ecs_cluster.ecs_cluster.id
  cluster_name               = var.cluster_name
  image_tag                  = var.mimir_worker_image
  desired_count              = 1
  public_subnets             = local.public_subnet_ids
  private_subnets            = local.private_subnet_ids
  ecs_capacity_provider_name = aws_ecs_capacity_provider.mimir_worker_capacity_provider.name
  environment                = "stag"
  planet_type                = "heimdall"
  poller_type                = "DiffPoller"
  short_poller_type          = "diff"
  use_jwt                    = false
  headless_endpoints = [
    "https://heimdall-internal-rpc.nine-chronicles.com/graphql"
  ]
  repository_credentials = var.repository_credentials
}

module "mimir_worker_heimdall_action_ec2" {
  source = "../../modules/mimir-worker-ec2"

  cpu                        = 2048
  memory                     = 1800
  vpc_id                     = local.vpc_id
  cluster_id                 = aws_ecs_cluster.ecs_cluster.id
  cluster_name               = var.cluster_name
  image_tag                  = var.mimir_worker_image
  desired_count              = 1
  public_subnets             = local.public_subnet_ids
  private_subnets            = local.private_subnet_ids
  ecs_capacity_provider_name = aws_ecs_capacity_provider.mimir_worker_capacity_provider.name
  environment                = "stag"
  planet_type                = "heimdall"
  poller_type                = "TxPoller"
  short_poller_type          = "tx"
  use_jwt                    = false
  headless_endpoints = [
    "https://heimdall-internal-rpc.nine-chronicles.com/graphql"
  ]
  repository_credentials = var.repository_credentials
}
