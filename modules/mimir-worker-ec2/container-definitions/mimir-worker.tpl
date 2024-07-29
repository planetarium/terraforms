[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/mimir-worker:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "environment": [
      {
        "name": "WORKER_Logging__LogLevel__System.Net.Http.HttpClient",
        "value": "Warning"
      },
      {
        "name": "WORKER_Configuration__ActivePollers__0",
        "value": "${poller_type}"
      },
      {
        "name": "WORKER_Configuration__EnableInitializing",
        "value": "true"
      },
      {
        "name": "WORKER_Configuration__MongoDbCAFile",
        "value": "/app/certs/global-bundle.p7b"
      },
      {
        "name": "WORKER_Configuration__DatabaseName",
        "value": "${mongodb_dbname}"
      }
    ],
    "secrets": [
      {
        "name": "WORKER_Configuration__MongoDbConnectionString",
        "valueFrom": "${mongodb_db_connection_string}"
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
