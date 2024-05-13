#!/bin/bash

IMAGE_NAME="neo4j-ent"
IMAGE_TAG="53"

docker build \
	--rm \
	--tag ${IMAGE_NAME}:${IMAGE_TAG} \
	.
