cluster_name = "dx"
region = "us-east-2"
mimir_image = "git-cd9188c6ff8fe69956db3c4777cef6ef00f874cc"
mimir_worker_image = "git-cd9188c6ff8fe69956db3c4777cef6ef00f874cc"
ncboard_image = "git-3c1bf8ca021471205f1db40a7ef758dca50c3e97"
existing_vpc_id = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block = "10.0.0.0/16"
existing_subnet_ids_public = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
network_conf_map = "odin-main=https://9c-main-full-state.nine-chronicles.com/graphql,heimdall-main=https://heimdall-full-state.nine-chronicles.com/graphql,odin-internal=https://9c-internal-rpc-1.nine-chronicles.com/graphql,heimdall-internal=https://heimdall-internal-rpc-1.nine-chronicles.com/graphql"
mimir_graphql_url_map = "main=https://mimir.nine-chronicles.dev/graphql/,internal=https://mimir-internal.nine-chronicles.dev/graphql/"
