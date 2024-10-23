cluster_name        = "mimir-itn"
region              = "us-east-2"
environment         = "stag"
mimir_image         = "git-3515b3e5f9b2a37ff4e2c08a2097ab2542a596b2"
mimir_worker_image  = "git-3515b3e5f9b2a37ff4e2c08a2097ab2542a596b2"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
create_nat_gateways = true
