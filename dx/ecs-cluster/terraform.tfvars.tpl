cluster_name = "dx"
region = "us-east-2"
mimir_image = "git-1c770040dcaca022df618627235e94dd3dc5dcec"
mimir_worker_image = "git-1c770040dcaca022df618627235e94dd3dc5dcec"
existing_vpc_id = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block = "10.0.0.0/16"
existing_subnet_ids_public = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
ncboard_image = "git-0d1d03ebed25b1e28f9c8964216fa95dd5121d3f"
network_conf_map = "odin=https://9c-main-full-state.nine-chronicles.com/graphql,heimdall=https://heimdall-full-state.nine-chronicles.com/graphql,odin-internal=https://9c-internal-rpc-1.nine-chronicles.com/graphql,heimdall-internal=https://heimdall-internal-rpc-1.nine-chronicles.com/graphql"
