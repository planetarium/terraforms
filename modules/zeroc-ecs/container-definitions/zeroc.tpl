[
  {
    "name": "zeroc",
    "image": "docker.io/atralupus/emptychronicle:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "command": ["--heimdall"],
    "environment": [
      {
        "name": "PN_StorePath",
        "value": "/data"
      }
    ],
    "portMappings": [
      { 
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${cluster_name}-zeroc-${environment}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "mountPoints": [
      {
        "sourceVolume": "zeroc-volume",
        "containerPath": "/data",
        "readOnly": false
      }
    ]
  }
]
