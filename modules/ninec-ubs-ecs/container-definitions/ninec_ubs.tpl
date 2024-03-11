[
  {
    "name": "ninecubs",
    "image": "docker.io/planetariumhq/9cutil-backend-store:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "environment": [
      {
        "name": "Configuration__EmptyChronicleBaseUrl",
        "value": "${emptychronicle_base_url}"
      },
      {
        "name": "Configuration__MongoDbConnectionString",
        "value": "${mongodb_db_connection_string}"
      },
      {
        "name": "Configuration__DatabaseName",
        "value": "${mongodb_dbname}"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${cluster_name}-ninecubs-${environment}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
