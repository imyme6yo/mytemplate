#!/bin/sh
# @AUTHOR: imyme6yo "imyme6yo@gmail.com"
# @DRAFT: 20200320
# @UPDATE: 20200405
MODE="project"
DIR="code"
PROJECT="myapp"

# Set MODE
if [ -n "$1" ] ; then
    if ! [ "$1" = "project" -o "$1" = "start" ] 
    then
        echo "Mode is `$1`\\n Mode should be either start or project."
        exit -1
    fi
    MODE=$1
fi

# Set NAME
if [ -n "$2" ] ; then
    PROJECT=$2
fi

# Set container name and image tag.
NAME="$PROJECT-01"
IMAGE="$PROJECT:dev"

# stop docker image
docker stop $NAME
# stop & rm docker container
docker rm $NAME
docker rmi $IMAGE
if [ "$MODE" = "project" ]; then
    # build image
    docker build --force-rm --build-arg DIR=$DIR --build-arg PROJECT=$PROJECT -t $IMAGE -f ./Dockerfile.project
    # run container
    docker run --rm -it -v $(pwd):/code --name $NAME $IMAGE sh /code/project.sh
elif [ "$MODE" = "start" ]; then
    # build image
    docker build --force-rm --build-arg DIR=$DIR --build-arg PROJECT=$PROJECT -t $IMAGE -f ./Dockerfile.startup
    # run container
    docker run --rm -it -v $(pwd):/code --name $NAME $IMAGE sh /code/startup.sh
fi