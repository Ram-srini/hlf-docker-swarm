#!/bin/bash

GLOBAL_ENV_LOCATION=$PWD/.env
source $GLOBAL_ENV_LOCATION
set -ev 

# KAFKA & ZOOKEEPER
docker stack deploy -c "$ZK1_COMPOSE_PATH" hlf_zk
docker stack deploy -c "$ZK2_COMPOSE_PATH" hlf_zk
docker stack deploy -c "$ZK3_COMPOSE_PATH" hlf_zk
sleep 3
docker stack deploy -c "$KAFKA1_COMPOSE_PATH" hlf_kafka
docker stack deploy -c "$KAFKA2_COMPOSE_PATH" hlf_kafka
docker stack deploy -c "$KAFKA3_COMPOSE_PATH" hlf_kafka
docker stack deploy -c "$KAFKA4_COMPOSE_PATH" hlf_kafka
docker stack deploy -c "$KAFKA5_COMPOSE_PATH" hlf_kafka
sleep 3
