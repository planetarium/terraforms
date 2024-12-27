cluster_name        = "mimir-main"
region              = "us-east-2"
environment         = "prod"
mimir_image         = "git-ba5ddc742bd4fa46157abb5719e2558b02548893"
mimir_worker_image  = "git-ba5ddc742bd4fa46157abb5719e2558b02548893"
vpc_cidr_block      = "10.0.0.0/16"
create_route_tables = true
