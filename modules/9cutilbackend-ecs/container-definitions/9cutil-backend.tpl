[
  {
    "name": "mongodb",
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
    ]
  }
]