cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-80ca3a2fc85b83500ab50ec06daabb9df4562630"
mimir_worker_image  = "git-80ca3a2fc85b83500ab50ec06daabb9df4562630"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
