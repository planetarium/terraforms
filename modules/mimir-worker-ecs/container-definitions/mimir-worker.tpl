[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/mimir-worker:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "secrets": [
      {
        "name": "WORKER_Configuration__MongoDbConnectionString",
        "valueFrom": "${mongodb_db_connection_string}"
      },
      {
        "name": "WORKER_Configuration__DatabaseName",
        "valueFrom": "${mongodb_dbname}"
      },
      %{ for secret in jwt_secrets ~}
      {
        "name": "${secret.name}",
        "valueFrom": "${secret.valueFrom}"
      },
      %{ endfor ~}
      {
        "name": "WORKER_Configuration__HeadlessEndpoint",
        "valueFrom": "${jwt_headless_endpoint}"
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
