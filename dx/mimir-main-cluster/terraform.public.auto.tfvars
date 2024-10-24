cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-e0291317b355161be2d15e1379b5463c306c4d53"
mimir_worker_image  = "git-e0291317b355161be2d15e1379b5463c306c4d53"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
