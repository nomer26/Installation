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


pc "light-cyan" "\n\
###############################\n\
##     Helm     Install      ##\n\
###############################"


curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2


pc "green" "\n\
###############################\n\
##     Helm     Repository   ##\n\
###############################"

helm repo add stable https://charts.helm.sh/stable
helm repo update




pc "green" "\n\
###############################\n\
##     Helm     Autocomplete ##\n\
###############################"

helm completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
source <(helm completion bash)



pc "light-cyan" "\n\
###############################\n\
##   Finished  Helm  Install ##\n\
###############################"


pc "red" " helm version : $(helm version --short)"
