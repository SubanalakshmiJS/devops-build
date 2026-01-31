#!/bin/bash
IMAGE_NAME=$1

docker stop react-app || true
docker rm react-app || true

docker run -d --name react-app -p 80:80 $IMAGE_NAME
