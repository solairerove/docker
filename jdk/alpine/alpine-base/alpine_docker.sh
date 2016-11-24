#!/bin/bash

IMAGE_NAME=alpine:base
CONTAINER_NAME=alpine-base

if [ "$1" = "build"  ]
then
    echo "Build image"
    docker build -t $IMAGE_NAME .
elif [ "$1" = "run" ]
then
    echo "Run container"
    docker run --name $CONTAINER_NAME -i -t -d $IMAGE_NAME
elif [ "$1" = "attach" ]
then
    docker attach $CONTAINER_NAME
elif [ "$1" = "rm" ]
then
    docker rm -f $CONTAINER_NAME
elif [ "$1" = "start" ]
then
    echo "Start container"
    docker start $CONTAINER_NAME
elif [ "$1" = "stop" ]
then
    echo "Stop container" docker stop $CONTAINER_NAME
    docker stop $CONTAINER_NAME
elif [ "$1" = "console" ]
then
    echo "Run console :"
    docker exec -it $CONTAINER_NAME /bin/sh
else
    echo "Execute with parameter build|run|rm|start|stop|app_start|app_stop|console"
fi
