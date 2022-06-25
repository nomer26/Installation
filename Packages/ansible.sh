#!/bin/bash

##################################

##    Kubectl   Installation   ##

##################################


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


pc "green" "
###############################\n\
## Install  Ansible          ##\n\
###############################"

sudo apt update
sudo apt install ansible -y


pc "green" "
#######################################\n\
## Finished Kubectl Installation  ##\n\
#######################################"

pc "red" "
ansible version : $(ansible --version)"
