module "mimir_worker_odin_diff_ec2" {
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
  environment                = "prod"
  planet_type                = "odin"
  poller_type                = "DiffPoller"
  short_poller_type          = "diff"
  headless_endpoints = [
    "http://9c-main-jwt.nine-chronicles.com/graphql",
    "http://odin-full-state.nine-chronicles.com/graphql",
    "http://9c-main-rpc-1.nine-chronicles.com/graphql",
    "http://9c-main-rpc-2.nine-chronicles.com/graphql"
  ]
  repository_credentials = var.repository_credentials
}

module "mimir_worker_odin_action_ec2" {
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
  environment                = "prod"
  planet_type                = "odin"
  poller_type                = "TxPoller"
  short_poller_type          = "tx"
  headless_endpoints = [
    "http://9c-main-jwt.nine-chronicles.com/graphql",
    "http://odin-full-state.nine-chronicles.com/graphql",
    "http://9c-main-rpc-1.nine-chronicles.com/graphql",
    "http://9c-main-rpc-2.nine-chronicles.com/graphql"
  ]
  repository_credentials = var.repository_credentials
}

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
  environment                = "prod"
  planet_type                = "heimdall"
  poller_type                = "DiffPoller"
  short_poller_type          = "diff"
  headless_endpoints = [
    "http://heimdall-jwt.nine-chronicles.com/graphql",
    "http://heimdall-full-state.nine-chronicles.com/graphql",
    "http://heimdall-rpc-1.nine-chronicles.com/graphql",
    "http://heimdall-rpc-2.nine-chronicles.com/graphql"
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
  environment                = "prod"
  planet_type                = "heimdall"
  poller_type                = "TxPoller"
  short_poller_type          = "tx"
  headless_endpoints = [
    "http://heimdall-jwt.nine-chronicles.com/graphql",
    "http://heimdall-full-state.nine-chronicles.com/graphql",
    "http://heimdall-rpc-1.nine-chronicles.com/graphql",
    "http://heimdall-rpc-2.nine-chronicles.com/graphql"
  ]
  repository_credentials = var.repository_credentials
}
