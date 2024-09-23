[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/mimir:${image}",
    "repositoryCredentials": {
      "credentialsParameter": "${repository_credentials}"
    },
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "environment": [
      {
        "name": "Database__Database",
        "value": "${mongodb_dbname}"
      },
      {
        "name": "Database__CAFile",
        "value": "/app/certs/global-bundle.p7b"
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
      },
      {
        "name": "Jwt__Issuer",
        "valueFrom": "${rate_limit_jwt_issuer}"
      },
      {
        "name": "Jwt__Key",
        "valueFrom": "${rate_limit_jwt_key}"
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
