#!/usr/bin/bash


set -e 

# check if image for autotests exist otherwise build autotest image
IMAGE="emersya.autotests.image"
CONTAINER="autotests"


imageExist=0
containerExist=0


if docker images | grep "$IMAGE";then
    imageExist=1
else
    imageExist=0
fi



if [ $imageExist == 0 ];
then
    docker build --no-cache -t "$IMAGE:0.1" .
fi



# check if container autotests exist otherwise create container autotests
if docker ps -a | grep "$CONTAINER";then
    containerExist=1
else
    containerExist=0
fi

if [ $containerExist == 0 ];then
    # create jenkinsdata folder if not exist
    if [ ! -d "/jenkinsdata" ];then
        sudo mkdir /jenkinsdata
        sudo chown -R 1000:1000 /jenkinsdata
    fi
    # create container 
    docker run \
        --name autotests \
        --detach \
        --restart on-failure \
        --env DOCKER_HOST=tcp://docker:2376 \
        --env DOCKER_CERT_PATH=/certs/client \
        --env DOCKER_TLS_VERIFY=1 \
        --publish 8080:8080 \
        --publish 50000:50000 \
        --workdir /var/jenkins_home \
        --volume /jenkinsdata:/var/jenkins_home \
        --volume jenkins-docker-certs:/certs/client:ro \
        --network host \
        "$IMAGE:0.1"
fi