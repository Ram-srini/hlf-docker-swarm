#!/bin/bash

set -ev

ENV_LOCATION=$PWD/.env
echo $ENV_LOCATION
source $ENV_LOCATION

FLAG="-i"
ARCH=$(uname)
if [ "$ARCH" == "Linux" ]; then
  FLAG="-i"
elif [ "$ARCH" == "Darwin" ]; then
  FLAG="-it"
fi

# Zookeeper + Kafka
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME1/g" $ZK1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME2/g" $ZK2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME1/g" $ZK3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME1/g" $KAFKA1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME2/g" $KAFKA2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME1/g" $KAFKA3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME2/g" $KAFKA4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME1/g" $KAFKA5_COMPOSE_PATH

# ORG1
ORG1_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org1.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME1/g" $ORDERER0_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME1/g" $PEER1_ORG1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME2/g" $PEER2_ORG1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME1/g" $SERVICE1_ORG1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG1_HOSTNAME2/g" $SERVICE2_ORG1_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG1_CA_PATH#g" $SERVICE1_ORG1_COMPOSE_PATH


# ORG2
ORG2_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org2.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME1/g" $ORDERER1_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME1/g" $PEER1_ORG2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME2/g" $PEER2_ORG2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME1/g" $SERVICE1_ORG2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG2_HOSTNAME2/g" $SERVICE2_ORG2_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG2_CA_PATH#g" $SERVICE1_ORG2_COMPOSE_PATH

# ORG3
ORG3_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org3.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME1/g" $ORDERER2_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME1/g" $PEER1_ORG3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME2/g" $PEER2_ORG3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME1/g" $SERVICE1_ORG3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG3_HOSTNAME2/g" $SERVICE2_ORG3_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG3_CA_PATH#g" $SERVICE1_ORG3_COMPOSE_PATH


# ORG4
ORG4_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org4.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME1/g" $ORDERER3_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME1/g" $PEER1_ORG4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME2/g" $PEER2_ORG4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME1/g" $SERVICE1_ORG4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG4_HOSTNAME2/g" $SERVICE2_ORG4_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG4_CA_PATH#g" $SERVICE1_ORG4_COMPOSE_PATH


# ORG5
ORG5_CA_PATH=$(ls /var/mynetwork/certs/crypto-config/peerOrganizations/org5.example.com/ca/ | grep "_sk")
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG5_HOSTNAME1/g" $ORDERER4_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG5_HOSTNAME1/g" $PEER1_ORG5_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG5_HOSTNAME2/g" $PEER2_ORG5_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG5_HOSTNAME1/g" $SERVICE1_ORG5_COMPOSE_PATH
sed "$FLAG" "s/- node.hostname == .*/- node.hostname == $ORG5_HOSTNAME2/g" $SERVICE2_ORG5_COMPOSE_PATH
sed "$FLAG" "s#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/.*#- FABRIC_CA_SERVER_CA_KEYFILE=/etc/hyperledger/fabric-ca-server-config/$ORG5_CA_PATH#g" $SERVICE1_ORG5_COMPOSE_PATH


if [ "$ARCH" == "Darwin" ]; then
  rm */**.ymlt
fi
