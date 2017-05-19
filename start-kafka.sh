#!/bin/bash

sudo docker stop kafka
sudo docker stop zookeeper

sudo docker run --rm -d --name zookeeper jplock/zookeeper:3.4.6
sudo docker run --rm -d --name kafka --link zookeeper:zookeeper ches/kafka

ZK_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' zookeeper)
KAFKA_IP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' kafka)
topic="tickets-email"

sudo docker run --rm ches/kafka kafka-topics.sh --create --topic ${topic} --replication-factor 1 --partitions 1 --zookeeper $ZK_IP:2181
