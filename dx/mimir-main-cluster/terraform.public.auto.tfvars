cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-b88ff10b9f1b586970502f02b2339f50c5bb89ac"
mimir_worker_image  = "git-b88ff10b9f1b586970502f02b2339f50c5bb89ac"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
