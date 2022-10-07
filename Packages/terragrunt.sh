#!/bin/bash

##################################
##    Terragrunt Installation   ##
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
##     Terragrunt  Install    ##\n\
###############################"

wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.39.0/terragrunt_linux_amd64

sudo mv terragrunt_linux_amd64 terragrunt

sudo chmod u+x terragrunt

sudo mv terragrunt /usr/local/bin/terragrunt

if [[ ! $PATH =~ "/usr/local/bin" ]];
then
  export PATH=$PATH:/usr/local/bin
fi


pc "magenta" "\n\
#########################################\n\
##     Finished  Terragrunt  Install    ##\n\
#########################################"


pc "red" "\n\
terragrunt version : $(terragrunt -v)"
