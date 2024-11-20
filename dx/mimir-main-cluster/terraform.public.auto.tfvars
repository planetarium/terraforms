cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-555c9e074deb32affcf9b7072facd930671cfd9c"
mimir_worker_image  = "git-555c9e074deb32affcf9b7072facd930671cfd9c"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
