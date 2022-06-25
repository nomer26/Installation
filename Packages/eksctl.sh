#!/bin/bash

##################################

##    EKSCTL   Installation   ##

##################################


function pc(){
  nc='\033[0m' # no color

  case $1 in
	"green") COLOR='\033[0;32m';;
	"red") COLOR='\033[0;31m';;
	"*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


pc "light-cyan" "
#####################\n\
## Install EKSctl ##\n\
#####################"


curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

. <(eksctl completion bash)

pc "light-cyan" "
#######################################\n\
## Finished EKSctl Installation     ###\n\
#######################################"

pc "red" "eksctl version : $(eksctl version)"
