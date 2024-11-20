cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-c93baa314da06fb28d4ec411c7aeb8a4a604d97f"
mimir_worker_image  = "git-c93baa314da06fb28d4ec411c7aeb8a4a604d97f"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
