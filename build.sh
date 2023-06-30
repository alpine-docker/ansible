#!/usr/bin/env bash

# Prerequisite
# Make sure you set secret enviroment variables in CI
# DOCKER_USERNAME
# DOCKER_PASSWORD

set -e

Usage() {
  echo "$0 [rebuild]"
}

image="alpine/ansible"
repo="ansible/ansible"
platform="linux/arm/v7,linux/arm64/v8,linux/arm/v6,linux/amd64,linux/ppc64le,linux/s390x" 

# Source the functions from extra lib.
curl -sL "https://raw.githubusercontent.com/alpine-docker/multi-arch-libs/stable/functions.sh" -o functions.sh
source functions.sh
install_jq
tag=$(get_latest_release "${repo}")
echo "Latest release is: ${tag}"

tag=8.1.0

build_arg="VERSION=${tag}"

status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tag})
echo $status

if [[ ( "${status}" =~ "not found" ) ||( ${REBUILD} == "true" ) ]]; then
   echo "build image for ${tag}"
   build_docker_image "${tag}" "${image}" "${platform}" "${build_arg}"
fi
