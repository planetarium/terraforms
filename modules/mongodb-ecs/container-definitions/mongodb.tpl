[
  {
    "name": "${container_name}",
    "image": "docker.io/mongo:latest",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 27017,
        "hostPort": 27017,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "mongo_data",
        "containerPath": "/data/db",
        "readOnly": false
      }
    ],
    "secrets": [
      {
        "name": "MONGO_INITDB_ROOT_USERNAME",
        "valueFrom": "${username_secret_arn}"
      },
      {
        "name": "MONGO_INITDB_ROOT_PASSWORD",
        "valueFrom": "${password_secret_arn}"
      }
    ]
  }
]
