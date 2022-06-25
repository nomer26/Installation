#!/bin/bash

##################################
##    awscli Installation   ##
##################################


function pc(){
  nc='\033[0m' # no color

  case $1 in
	"green") COLOR='\033[0;32m';;
	"red") COLOR='\033[0;31m';;
	"blue") COLOR='\033[0;34m';;
	"yellow") COLOR='\033[0;33m';;
	"cyan") COLOR='\033[0;36m';;
	"white") cOLOR='\033[0;37m';;
	"*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


pc "yellow" "\n\
###############################\n\
##     AWS CLI  Install      ##\n\
###############################"


curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install


pc "yellow" "\n\
#########################################\n\
##     Finished  AWS CLI  Install      ##\n\
#########################################"




pc "red" "\n\
awscli version : $(aws --version)"

