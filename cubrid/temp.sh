#!/bin/bash

CANONICAL_PATH=`readlink -f $(dirname ${BASH_SOURCE})`

VERSION=`cd ${CANONICAL_PATH} && cat version`
VERSION_BASE=`cd ${CANONICAL_PATH} && cat version_base`

CREATED=`date -d @$(stat --printf='%Z' ${CANONICAL_PATH}/Dockerfile) -u +'%Y-%m-%dT%H:%M:%SZ'`
REVISION=`cd ${CANONICAL_PATH} && git log -1 --format=%h`
REF_NAME=`cd ${CANONICAL_PATH} && git symbolic-ref -q --short HEAD`


echo "BASH_SOURCE : ${BASH_SOURCE}"
echo "VERSION : ${VERSION}"
echo "VERSION_BASE : ${VERSION_BASE}"
echo "CREATED : ${CREATED}"
echo "REVISION : ${REVISION}"
echo "REF_NAME : ${REF_NAME}"

