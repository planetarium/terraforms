cluster_name = "dx"
region = "us-east-2"
mimir_image = "git-b086ac376fe434d474bf7d72fefea0586f65ad38"
mimir_worker_image = "git-b086ac376fe434d474bf7d72fefea0586f65ad38"
ncboard_image = "git-52657be1cda0b6a432a0ff37873f786c1b43fc7f"
existing_vpc_id = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block = "10.0.0.0/16"
existing_subnet_ids_public = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
network_conf_map = "odin-main=https://9c-main-full-state.nine-chronicles.com/graphql,heimdall-main=https://heimdall-full-state.nine-chronicles.com/graphql,odin-internal=https://9c-internal-rpc-1.nine-chronicles.com/graphql,heimdall-internal=https://heimdall-internal-rpc-1.nine-chronicles.com/graphql"
