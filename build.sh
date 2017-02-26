#!/bin/sh

IMAGE=nlmacamp/amq
REPO=dockerhub.novamedia.com
VERSION=6.3.0

#
# Set the version also in the Dockerfile
# as of version 1.9 of docker we can start using --build-arg
# for 1.8 it's not supported yet
#
#ID=$(docker build --build-arg version=$VERSION -q -t $IMAGE . | tee  2>/dev/null | awk '/sha/{print $NF}')

echo "docker build -q -t $IMAGE . | tee  2>/dev/null | awk -F ':' '/sha256/{print $NF}'"
ID=$(docker build -q -t $IMAGE . | tee  2>/dev/null | awk -F ':' '/sha256/{print $NF}')
echo ID: $ID
docker tag $ID $REPO/$IMAGE:$VERSION # Add a new tag
docker tag $ID $REPO/$IMAGE:latest   # Force latest tag

echo image $ID tagged as $REPO/$IMAGE:$VERSION and as latest
#docker push $REPO/$IMAGE                # push to repo
