#!/bin/bash
echo ECS_CLUSTER=${ecs_cluster_name} >> /etc/ecs/ecs.config
echo ECS_INSTANCE_ATTRIBUTES='{"custom-attribute": "instance-for-zeroc"}' >> /etc/ecs/ecs.config

yum install -y unzip

mkdir -p /zeroc-chain

curl -o /tmp/9c-main-snapshot.zip https://snapshots.nine-chronicles.com/main/heimdall/partition/full/9c-main-snapshot.zip

unzip /tmp/9c-main-snapshot.zip -d /zeroc-chain

rm /tmp/9c-main-snapshot.zip
