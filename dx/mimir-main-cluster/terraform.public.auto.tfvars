cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-4301f8440243fb2ae52684f3dd40313fb84c4de0"
mimir_worker_image  = "git-4301f8440243fb2ae52684f3dd40313fb84c4de0"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
