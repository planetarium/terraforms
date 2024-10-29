cluster_name        = "mimir-itn"
region              = "us-east-2"
environment         = "stag"
mimir_image         = "git-71a7cf3101622721936dd6626e78a6f2bfdc628f"
mimir_worker_image  = "git-71a7cf3101622721936dd6626e78a6f2bfdc628f"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
create_nat_gateways = true
