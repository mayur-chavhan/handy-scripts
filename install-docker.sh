#!/usr/bin/env bash

set -o errexit
set -o nounset

sudo true

function INSTALL_DOCKER (){
    # Install Docker from Official Website.
    if ! [ -x $(command -v docker) ]; then

        wget -qO- https://get.docker.com/ | sh

    else
        echo -e "\n Docker is already INSTALLED \n"
        exit 0
    fi
}

function INSTALL_DC (){

    if ! [ -x $(command -v docker-compose) ]; then
        # Install docker-compose
        COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1`
        sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
        sudo chmod +x /usr/local/bin/docker-compose
        sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
    else 
        echo -e "\n Docker-Compose is already INSTALLED \n"
        exit 0
    fi
}

function DOCKER_CLEANUP (){
    # Install docker-cleanup command
    cd /tmp
    git clone https://gist.github.com/76b450a0c986e576e98b.git
    cd 76b450a0c986e576e98b
    sudo mv docker-cleanup /usr/local/bin/docker-cleanup
    sudo chmod +x /usr/local/bin/docker-cleanup
}


INSTALL_DOCKER

INSTALL_DC

DOCKER_CLEANUP