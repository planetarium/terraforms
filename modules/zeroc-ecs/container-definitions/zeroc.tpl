[
  {
    "name": "${container_name}",
    "image": "docker.io/planetariumhq/emptychronicle:${image}",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "command": ["--heimdall"],
    "environment": [
      {
        "name": "PN_StorePath",
        "value": "/zeroc-chain"
      },
      {
        "name": "PN_ActionEvaluatorRanges__0__StartBlockIndex",
        "value": "0"
      },
      {
        "name": "PN_ActionEvaluatorRanges__0__EndBlockIndex",
        "value": "265299"
      },
      {
        "name": "PN_ActionEvaluatorRanges__0__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/8df91845e16ab5e445a35125588007c10814150c/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__1__StartBlockIndex",
        "value": "265300"
      },
      {
        "name": "PN_ActionEvaluatorRanges__1__EndBlockIndex",
        "value": "335183"
      },
      {
        "name": "PN_ActionEvaluatorRanges__1__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/06ccead46d51b2868942a0996e10e21b99c1726f/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__2__StartBlockIndex",
        "value": "335184"
      },
      {
        "name": "PN_ActionEvaluatorRanges__2__EndBlockIndex",
        "value": "520160"
      },
      {
        "name": "PN_ActionEvaluatorRanges__2__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/eb4e8827dd6fd2e8b88812fdfed725e2c3beb334/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__3__StartBlockIndex",
        "value": "520161"
      },
      {
        "name": "PN_ActionEvaluatorRanges__3__EndBlockIndex",
        "value": "812970"
      },
      {
        "name": "PN_ActionEvaluatorRanges__3__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/a9cca56c1c62214dd29d70bdcb40b16d1e8ca090/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__4__StartBlockIndex",
        "value": "812971"
      },
      {
        "name": "PN_ActionEvaluatorRanges__4__EndBlockIndex",
        "value": "1026580"
      },
      {
        "name": "PN_ActionEvaluatorRanges__4__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/e482c5988c75782d55525a91110d79e8c3353821/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__5__StartBlockIndex",
        "value": "1026581"
      },
      {
        "name": "PN_ActionEvaluatorRanges__5__EndBlockIndex",
        "value": "1030975"
      },
      {
        "name": "PN_ActionEvaluatorRanges__5__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/0c6d74ebdc3a73cb73fc559e3857d9e688997053/linux-arm64.zip"
      },
      {
        "name": "PN_ActionEvaluatorRanges__6__StartBlockIndex",
        "value": "1030976"
      },
      {
        "name": "PN_ActionEvaluatorRanges__6__EndBlockIndex",
        "value": "9223372036854775807"
      },
      {
        "name": "PN_ActionEvaluatorRanges__6__PluginPath",
        "value": "https://9c-dx.s3.ap-northeast-2.amazonaws.com/Lib9c.Plugin/f744ce3b165eea3115b2da4866de232fd4367fb3/linux-arm64.zip"
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
        "awslogs-group": "${log_group_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "ecs"
      }
    },
    "mountPoints": [
      {
        "sourceVolume": "${container_name}-volume",
        "containerPath": "/${container_name}-chain",
        "readOnly": false
      }
    ]
  }
]
