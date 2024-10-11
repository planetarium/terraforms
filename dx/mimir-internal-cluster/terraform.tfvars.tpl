cluster_name                 = "mimir-itn"
region                       = "us-east-2"
environment                  = "prod"
mimir_image                  = "git-74c080f992e75b9c6c2b269306d3b9dee05dda1c"
mimir_worker_image           = "git-0981a5a01914b672ecfbd7ba9d0cf87f10f972af"
existing_vpc_id              = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block               = "10.0.0.0/16"
existing_subnet_ids_public   = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private  = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
existing_internet_gateway_id = op://DX/DX Ecs Cluster tfvars/add more/existing_internet_gateway_id
db_username                  = op://DX/DX Ecs Cluster tfvars/add more/db_username
create_route_tables          = true
create_nat_gateways          = true
repository_credentials       = "op://DX/DX Ecs Cluster tfvars/add more/repository_credentials"
tags = {
  Team = "9c-dx"
}
