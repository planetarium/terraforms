[
  {
    "name": "ninecubs",
    "image": "docker.io/planetariumhq/9cutil-backend-store:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "secrets": [
      {
        "name": "STORE_Configuration__EmptyChronicleBaseUrl",
        "valueFrom": "${emptychronicle_base_url}"
      },
      {
        "name": "STORE_Configuration__MongoDbConnectionString",
        "valueFrom": "${mongodb_db_connection_string}"
      },
      {
        "name": "STORE_Configuration__DatabaseName",
        "valueFrom": "${mongodb_dbname}"
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
