#!/bin/bash

sudo true

function install_docker() {
#check docker is alreadu installed
if [ -x "$(command -v docker)" ]; then
  echo 'Docker is already installed.'
else
  echo -e "\nInstalling Docker\n"
  wget -qO- https://get.docker.com/ | sh
  wait
fi

}

function install_docker_compose() {
# check if docker-compose is already installed
if [ -x "$(command -v docker-compose)" ]; then
  echo 'Docker-compose is already installed.'
  exit 0
else
  echo -e "\nInstalling Docker-compose\n"
  # Install docker-compose
  COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "([0-9]{1,4}(\.[0-9a-z]{1,6}){1,5})" | sort --version-sort | tail -n 1`
  echo -e "\nInstalling Docker-Compose Version: $COMPOSE_VERSION \n"
  sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
  sudo chmod +x /usr/local/bin/docker-compose
  sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"
  wait
fi
}

install_docker
install_docker_compose

# check if docker-cleanup is already installed
if [ -x "$(command -v docker-cleanup)" ]; then
  echo 'Docker-cleanup is already installed.'
  exit 0
else
  echo -e "\nInstalling Docker-cleanup\n"
  # Install docker-cleanup
  sudo curl -L https://raw.githubusercontent.com/docker/docker-cleanup/master/docker-cleanup-ubuntu.sh | sudo bash
  wait
fi
