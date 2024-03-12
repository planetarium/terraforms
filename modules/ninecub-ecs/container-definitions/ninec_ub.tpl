[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/9cutil-backend:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "secrets": [
      {
        "name": "Database__ConnectionString",
        "valueFrom": "${mongodb_connection_string}"
      },
      {
        "name": "Database__DatabaseName",
        "valueFrom": "${mongodb_dbname}"
      },
      {
        "name": "StateService__HeadlessEndpoint",
        "valueFrom": "${jwt_headless_endpoint}"
      },
      {
        "name": "StateService__JwtSecretKey",
        "valueFrom": "${jwt_secret_key}"
      },
      {
        "name": "StateService__JwtIssuer",
        "valueFrom": "${jwt_issuer}"
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
