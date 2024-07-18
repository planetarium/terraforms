module "mimir_odin_ec2" {
  source = "../../modules/mimir-ec2"

  cpu            = 1024
  memory         = 950
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  image_tag      = var.mimir_image
  desired_count  = 2
  public_subnets = local.public_subnet_ids
  private_subnets = local.private_subnet_ids
  ecs_capacity_provider_name = aws_ecs_capacity_provider.mimir_capacity_provider.name
  network        = "odin"
  environment    = "prod"
}

module "mimir_heimdall_ec2" {
  source = "../../modules/mimir-ec2"

  cpu            = 1024
  memory         = 950
  vpc_id         = local.vpc_id
  cluster_id     = aws_ecs_cluster.ecs_cluster.id
  cluster_name   = var.cluster_name
  image_tag      = var.mimir_image
  desired_count  = 2
  public_subnets = local.public_subnet_ids
  private_subnets = local.private_subnet_ids
  ecs_capacity_provider_name = aws_ecs_capacity_provider.mimir_capacity_provider.name
  network        = "heimdall"
  environment    = "prod"
}
