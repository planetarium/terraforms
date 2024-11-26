cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-a231b946c1d1a70f2265256606b601893f63bd33"
mimir_worker_image  = "git-a231b946c1d1a70f2265256606b601893f63bd33"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
