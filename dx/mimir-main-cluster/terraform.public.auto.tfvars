cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-822a0c3e92d5c68c777bdc43168f589e8e668c72"
mimir_worker_image  = "git-822a0c3e92d5c68c777bdc43168f589e8e668c72"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
