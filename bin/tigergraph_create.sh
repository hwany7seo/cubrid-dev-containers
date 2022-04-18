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
  --volume ${VOLUME_NAME}:/home \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --cap-add=ALL \
  --privileged \
  --restart always \
  -p 14022:22 \
  -p 9000:9000 \
  -p 14240:14240 \
  --ulimit nofile=1000000:1000000 \
  -t docker.tigergraph.com/tigergraph:2.4.1

${CANONICAL_PATH}/ip_address_update.sh

