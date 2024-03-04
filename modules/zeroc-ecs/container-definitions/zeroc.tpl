[
  {
    "name": "mongodb",
    "image": "docker.io/planetariumhq/emptychronicle:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5009,
        "hostPort": 5009,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "zeroc_data",
        "containerPath": "/data/db",
        "readOnly": false
      }
    ]
  }
]