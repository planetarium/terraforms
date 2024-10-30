cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-e5b0f8e38a76c66ad088bbbeba31bebca7818289"
mimir_worker_image  = "git-e5b0f8e38a76c66ad088bbbeba31bebca7818289"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
