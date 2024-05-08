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
      {
        "name": "WORKER_Configuration__HeadlessEndpoint",
        "valueFrom": "${jwt_headless_endpoint}"
      },
      {
        "name": "WORKER_Configuration__JwtSecretKey",
        "valueFrom": "${jwt_secret_key}"
      },
      {
        "name": "WORKER_Configuration__JwtIssuer",
        "valueFrom": "${jwt_issuer}"
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
