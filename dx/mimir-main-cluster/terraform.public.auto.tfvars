cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-0bc31e547d638627200d529696ba89979643f020"
mimir_worker_image  = "git-0bc31e547d638627200d529696ba89979643f020"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
