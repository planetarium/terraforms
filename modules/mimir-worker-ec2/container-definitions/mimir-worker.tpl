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
      %{ for index, endpoint in headless_endpoints ~}
      {
        "name": "WORKER_Configuration__HeadlessEndpoints__${index}",
        "value": "${endpoint}"
      },
      %{ endfor ~}
      {
        "name": "WORKER_Configuration__PollerType",
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
        "name": "WORKER_Configuration__PlanetType",
        "value": "${planet_type}"
      }
    ],
    "secrets": [
      %{ for secret in jwt_secrets ~}
      {
        "name": "${secret.name}",
        "valueFrom": "${secret.valueFrom}"
      },
      %{ endfor ~}
      {
        "name": "WORKER_Configuration__MongoDbConnectionString",
        "valueFrom": "${mongodb_db_connection_string}"
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
