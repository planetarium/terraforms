cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-d4c4bb9c19cb5deac41a0b9d7359f5ff59c3161e"
mimir_worker_image  = "git-d4c4bb9c19cb5deac41a0b9d7359f5ff59c3161e"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
