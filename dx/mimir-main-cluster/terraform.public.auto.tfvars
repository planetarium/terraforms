cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-e22807892aa499eb8216cf34049bf929e6d19945"
mimir_worker_image  = "git-e22807892aa499eb8216cf34049bf929e6d19945"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
