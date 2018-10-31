#!/bin/bash
GLOBAL_ENV_LOCATION=$PWD/.env
source $GLOBAL_ENV_LOCATION

set -ev

# ORG 2
docker stack deploy -c "$ORDERER1_COMPOSE_PATH" hlf_orderer
sleep 3
docker stack deploy -c "$SERVICE1_ORG2_COMPOSE_PATH" hlf_services
docker stack deploy -c "$SERVICE2_ORG2_COMPOSE_PATH" hlf_services
sleep 3
docker stack deploy -c "$PEER1_ORG2_COMPOSE_PATH" hlf_peer
docker stack deploy -c "$PEER2_ORG2_COMPOSE_PATH" hlf_peer

