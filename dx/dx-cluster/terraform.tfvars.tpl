cluster_name = "dx"
region = "us-east-2"
mimir_image = "git-56ef8641ad637dea6a142006ff22d1c31709b0ca"
mimir_worker_image = "git-56ef8641ad637dea6a142006ff22d1c31709b0ca"
ncboard_image = "git-f01240f0f389bff014d57ba116a6c4a2fe7c88de"
existing_vpc_id = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block = "10.0.0.0/16"
existing_subnet_ids_public = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
network_conf_map = "odin=https://9c-main-full-state.nine-chronicles.com/graphql,heimdall=https://heimdall-full-state.nine-chronicles.com/graphql,odin-internal=https://9c-internal-rpc-1.nine-chronicles.com/graphql,heimdall-internal=https://heimdall-internal-rpc-1.nine-chronicles.com/graphql"
mimir_graphql_url_map = "odin=https://mimir.nine-chronicles.dev/odin/graphql/,heimdall=https://mimir.nine-chronicles.dev/heimdall/graphql/"