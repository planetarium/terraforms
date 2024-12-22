cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-e35d564ad57d8f731be6f3e8d510fd321bd10022"
mimir_worker_image  = "git-12e2f4bb05d148e524cd456edb1d1b2f5334f079"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
