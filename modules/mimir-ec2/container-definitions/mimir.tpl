[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/mimir:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "environment": [
      {
        "name": "Database__Database",
        "value": "${mongodb_dbname}"
      }
    ],
    "secrets": [
      {
        "name": "Database__ConnectionString",
        "valueFrom": "${mongodb_connection_string}"
      },
      %{ for secret in jwt_secrets ~}
      {
        "name": "${secret.name}",
        "valueFrom": "${secret.valueFrom}"
      },
      %{ endfor ~}
      {
        "name": "StateService__HeadlessEndpoint",
        "valueFrom": "${jwt_headless_endpoint}"
      }
    ],
    "portMappings": [
      { 
        "containerPort": 8080,
        "hostPort": 8080,
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
