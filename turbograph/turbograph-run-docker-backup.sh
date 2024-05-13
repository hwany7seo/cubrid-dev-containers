#!/bin/bash

if [ $# != 1 ]; then
  echo "$# is Illegal number of parameters."
  echo "Usage: $0 <IP_D_CLASS>"
  exit
fi

IP_D_CLASS=$1
CONTAINER_NAME=turbograph-${IP_D_CLASS}
VOLUME_NAME=development-cubrid_${CONTAINER_NAME}_${IP_D_CLASS}_home
PROJECT_DIR=${VOLUME_NAME}_project
DATA_DIR=${VOLUME_NAME}_data
SOURCE_DATA_DIR=${DATA_DIR}
# Parse user input

# Target image
#IMAGE_NAME="turbograph-image-v1"
IMAGE_NAME="turbograph-54-lastbackup"
IMAGE_TAG="latest"

# TODO override from user input
SHARED_MEM_SIZE="100g"
# TODO add ulimit

CONTAINER_UID=$(id -u)
CONTAINER_GID=$(id -g)
CONTAINER_USERNAME="$(whoami)"
#PROJECT_DIR=$( dirname $( readlink -f $( dirname -- "$0" ) ) )
#[[ -z "$1" ]] && { echo "Provide DATA_DIR where data will be stored to!!!"; exit 1;}
#DATA_DIR=$1
#[[ -z "$2" ]] && { echo "Provide SOURCE_DATA_DIR where you load input data!!!"; exit 1;}
#SOURCE_DATA_DIR=$2

# TODO you need to set /etc/passwd thus make another user, to access vscode
# TODO and then mkdir /home/USERNAME and chown
# TODO set entrypoints refer to commercial dbmss 
	# e.g. https://github.com/docker-library/postgres/blob/master/12/bullseye/docker-entrypoint.sh

	#--user "${CONTAINER_USERNAME}:${CONTAINER_GID}" \

#if [ `docker volume ls --format "{{.Name}}" | grep ${VOLUME_NAME} | wc -l` == 0 ]; then
#  docker volume create ${VOLUME_NAME}
#fi

#if [ `docker volume ls --format "{{.Name}}" | grep ${PROJECT_DIR} | wc -l` == 0 ]; then
#  docker volume create ${PROJECT_DIR}
#fi

#if [ `docker volume ls --format "{{.Name}}" | grep ${DATA_DIR} | wc -l` == 0 ]; then
#  docker volume create ${DATA_DIR}
#fi

docker run -itd --cap-add SYS_ADMIN \
	--cap-add SYS_PTRACE \
  -v ${VOLUME_NAME}:/home \
	-v ${PROJECT_DIR}:/turbograph-v3 \
	-v ${DATA_DIR}:/data \
	-v ${SOURCE_DATA_DIR}:/source-data \
	--shm-size=${SHARED_MEM_SIZE} \
	--entrypoint="/usr/sbin/init" \
	--name ${CONTAINER_NAME} \
  --hostname ${CONTAINER_NAME} \
  --network dev-net \
  --privileged \
  --ip=192.168.2.${IP_D_CLASS} \
	${IMAGE_NAME}:${IMAGE_TAG}

# TODO fix this.
#	-c "groupadd -g ${CONTAINER_GID} ${CONTAINER_USERNAME}; useradd -u ${CONTAINER_UID} -g ${CONTAINER_GID} -ms /bin/bash ${CONTAINER_USERNAME}; tail -f /dev/null;"
