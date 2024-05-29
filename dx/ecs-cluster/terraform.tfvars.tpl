cluster_name = "dx"
region = "us-east-2"
mimir_image = "git-eba01adea7281675d31cf60f8f8d8bf08ba6921f"
mimir_worker_image = "git-eba01adea7281675d31cf60f8f8d8bf08ba6921f"
ncboard_image = "git-6a5e1d62deeb53cc98a4c17118d35ba0bde2ba0a"
existing_vpc_id = "op://DX/DX Ecs Cluster tfvars/add more/vpc_id"
vpc_cidr_block = "10.0.0.0/16"
existing_subnet_ids_public = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public
existing_subnet_ids_private = op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_private
network_conf_map = "odin-main=https://9c-main-full-state.nine-chronicles.com/graphql,heimdall-main=https://heimdall-full-state.nine-chronicles.com/graphql,odin-internal=https://9c-internal-rpc-1.nine-chronicles.com/graphql,heimdall-internal=https://heimdall-internal-rpc-1.nine-chronicles.com/graphql"
mimir_graphql_url_map = "main=https://mimir.nine-chronicles.dev/graphql/,internal=https://mimir-internal.nine-chronicles.dev/graphql/"
