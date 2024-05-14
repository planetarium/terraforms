[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/9c-board:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "secrets": [],
    "environment": [
      {
        "name": "NETWORK_CONF_MAP",
        "value": "${network_conf_map}"
      }
    ],
    "portMappings": [
      { 
        "containerPort": 3000,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
