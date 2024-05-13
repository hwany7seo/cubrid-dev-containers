#!/bin/bash

IMAGE_NAME="centos"
IMAGE_TAG="centos8.2.2004"

docker rmi ${IMAGE_NAME}

docker build \
	--rm \
	--tag ${IMAGE_NAME}:${IMAGE_TAG} \
	.
