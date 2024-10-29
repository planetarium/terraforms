cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-82537d4cc84b3cf33b0c8001c622b14404a3c9fd"
mimir_worker_image  = "git-82537d4cc84b3cf33b0c8001c622b14404a3c9fd"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
