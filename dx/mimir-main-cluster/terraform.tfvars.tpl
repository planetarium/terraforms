cluster_name                 = "mimir-main"
region                       = "us-east-2"
environment                  = "prod"
mimir_image                  = "git-80ca3a2fc85b83500ab50ec06daabb9df4562630"
mimir_worker_image           = "git-80ca3a2fc85b83500ab50ec06daabb9df4562630"
existing_vpc_id              = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block               = "10.0.0.0/16"
existing_subnet_ids_public   = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private  = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
existing_internet_gateway_id = "op://DX/DX Ecs Cluster tfvars/add more/existing_internet_gateway_id"
db_username                  = "op://DX/DX Ecs Cluster tfvars/add more/db_username"
create_route_tables          = true
repository_credentials       = "op://DX/DX Ecs Cluster tfvars/add more/repository_credentials"
tags = {
  Team = "9c-dx"
}
