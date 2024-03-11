[
  {
    "name": "ninecub",
    "image": "docker.io/planetariumhq/9cutil-backend:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "environment": [
      {
        "name": "Database__ConnectionString",
        "value": "${mongodb_connection_string}"
      },
      {
        "name": "Database__DatabaseName",
        "value": "${mongodb_dbname}"
      },
      {
        "name": "StateService__HeadlessEndpoint",
        "value": "${jwt_headless_endpoint}"
      },
      {
        "name": "StateService__JwtSecretKey",
        "value": "${jwt_secret_key}"
      },
      {
        "name": "StateService__JwtIssuer",
        "value": "${jwt_issuer}"
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
        "awslogs-group": "/ecs/${cluster_name}-ninecub-${environment}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
