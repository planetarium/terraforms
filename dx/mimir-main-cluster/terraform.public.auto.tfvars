cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-6ec46f0fea22048a31bde95444621e5b9351e405"
mimir_worker_image  = "git-6ec46f0fea22048a31bde95444621e5b9351e405"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
