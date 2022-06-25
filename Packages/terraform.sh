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
        "white") COLOR='\033[0;37m';;
        "light-cyan") COLOR='\033[0;96m';;
        "dark-gray") COLOR='\033[1;30m';;
        "magenta") COLOR='\033[0;35m';;
        "*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


pc "magenta" "\n\
###############################\n\
##     Terraform  Install    ##\n\
###############################"

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

pc "magenta" "\n\
#########################################\n\
##     Finished  Terraform  Install    ##\n\
#########################################"

pc "green" "
##################################\n\
##  Terraform  autocomplete     ##\n\
##################################"

terraform -install-autocomplete

pc "red" "\n\
terraform version : $(terraform version)"
