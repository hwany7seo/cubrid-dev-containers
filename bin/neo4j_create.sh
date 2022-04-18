#!/bin/bash

if [ $# != 2 ]; then
  echo "$# is Illegal number of parameters."
  echo "Usage: $0 <CONTAINER_NAME> <IP_D_CLASS>"
  exit
fi

CONTAINER_NAME=$1
IP_D_CLASS=$2

CANONICAL_PATH=`readlink -f $(dirname ${BASH_SOURCE})`

VOLUME_NAME="development-cubrid_${CONTAINER_NAME}_${IP_D_CLASS}_data"

docker run --detach \
  --name ${CONTAINER_NAME} \
  --hostname ${CONTAINER_NAME} \
  --network dev-net \
  --ip=192.168.2.${IP_D_CLASS} \
  --env=NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
  --volume=$HOME/neo4j/data:/data \
  --volume=$HOME/neo4j/logs:/logs \
  --cap-add=ALL \
  --privileged \
  --restart always \
  -p 7474:7474 \
  -p 7687:7687 \
  --env NEO4JLABS_PLUGINS='["apoc", "apoc-core", "bloom", "streams", "graph-data-science", "n10s"]' \
  neo4j:enterprise

${CANONICAL_PATH}/ip_address_update.sh

