#!/bin/bash

function pc(){
  nc='\033[0m' # no color

  case $1 in
        "green") COLOR='\033[0;32m';;
        "red") COLOR='\033[0;31m';;
        "blue") COLOR='\033[0;34m';;
        "yellow") COLOR='\033[0;33m';;
        "cyan") COLOR='\033[0;36m';;
        "white") COLOR='\033[0;37m';;
        "light-cyan") COLOR='\033[0;96m';;
        "dark-gray") COLOR='\033[1;30m';;
        "magenta") COLOR='\033[0;35m';;
        "*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


## SW pkg for APT Repository 
pc "green" "
###############################\n\
## SW pkg for APT Repository ##\n\
###############################"

sudo apt-get update -y

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release


## Add Docker Repository  
pc "green" "
###############################\n\
## Add Docker Repository     ##\n\
###############################"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y


## Install Docker Enging &  Container Runtime 
pc "green" "
###################################################\n\
## Install Docker Enging & Container Runtime     ##\n\
###################################################"

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

pc "green" " Finished  Docker Installation... "

sudo usermod -aG docker $USER

docker version | grep -iB 2 version

pc "red" "\n\n\n##  You must reboot this terminal to apply modification ##"
