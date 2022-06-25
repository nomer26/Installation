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
	"*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


pc "cyan" "\n\
###############################\n\
##   Docker-compose Install   ##\n\
###############################"


sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


pc "cyan" "\n\
########################################\n\
##   Finished Docker-compose Install  ##\n\
########################################"

pc "red" "Docker-compose version : $(docker-compose -version)"


