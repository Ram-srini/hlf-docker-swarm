#!/bin/bash
#
# Copyright Skcript Technologies Pvt. Ltd All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# set -ev

source ${PWD}/.env
export PATH=$PATH:${PWD}/bin
export FABRIC_CFG_PATH=${PWD}

# remove previous crypto material and config transactions
rm -fr config/*
rm -fr crypto-config/*
rm -fr idemix-config/*
mkdir -p crypto-config idemix-config config


# generate crypto material
cryptogen generate --config=./crypto-config.yaml
if [ "$?" -ne 0 ]; then
  echo "Failed to generate crypto material..."
  exit 1
fi

#Generate idemix crypto material using idemixgen tool
idemixgen ca-keygen
idemixgen signerconfig -u OU1 -e OU1 -r 1

# generate genesis block for orderer
configtxgen -profile OrdererGenesis -channelID $CHANNEL_NAME -outputBlock ./config/genesis.block
if [ "$?" -ne 0 ]; then
  echo "Failed to generate orderer genesis block..."
  exit 1
fi


# generate channel configuration transaction for My Channel
configtxgen -profile ${CHANNEL_PROFILE} -outputCreateChannelTx ./config/${CHANNEL_NAME}.tx -channelID $CHANNEL_NAME
if [ "$?" -ne 0 ]; then
  echo "Failed to generate channel configuration transaction..."
  exit 1
fi

# generate anchor peer for My Channel transaction as ORG1 Org
configtxgen -profile ${CHANNEL_PROFILE} -outputAnchorPeersUpdate ./config/ORG1${ANCHOR_TX} -channelID $CHANNEL_NAME -asOrg Org1MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org1MSP..."
  exit 1
fi

# generate anchor peer for My Channel transaction as ORG2 Org
configtxgen -profile ${CHANNEL_PROFILE} -outputAnchorPeersUpdate ./config/ORG2${ANCHOR_TX} -channelID $CHANNEL_NAME -asOrg Org2MSP
if [ "$?" -ne 0 ]; then
  echo "Failed to generate anchor peer update for Org2MSP..."
  exit 1
fi
