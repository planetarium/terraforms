[
  {
    "name": "zeroc",
    "image": "docker.io/planetariumhq/emptychronicle:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "command": ["/app/myapp", "--heimdall"],
    "environment": [
      {
        "name": "PN_StorePath",
        "value": "/data"
      }
    ],
    "portMappings": [
      { 
        "containerPort": 5009,
        "hostPort": 5009,
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
        "sourceVolume": "zeroc_data",
        "containerPath": "/data",
        "readOnly": false
      }
    ]
  }
]
