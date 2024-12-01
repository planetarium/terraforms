cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-d16c830a5695e18ead0424e07c0f1ce383bb23ad"
mimir_worker_image  = "git-6c86af48867ab5a09b47052a4d0c4bfeaae8ccb0"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
