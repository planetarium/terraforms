cluster_name        = "mimir-itn"
region              = "us-east-2"
environment         = "stag"
mimir_image         = "git-e5b0f8e38a76c66ad088bbbeba31bebca7818289"
mimir_worker_image  = "git-e5b0f8e38a76c66ad088bbbeba31bebca7818289"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
create_nat_gateways = true
