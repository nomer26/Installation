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


VERSION=

while [ -z $VERSION ]
do
  read -p "Enter The Version of kubectl you want  (e.g. 1.21.12-00) : " VERSION
done
##  Add Kubernetes Repository 

pc "green" "
###############################\n\
## Add Kubernetes Repository ##\n\
###############################"

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y



##  Install  K8S
pc "blue" "
#####################\n\
## Install kubectl ##\n\
#####################"


sudo apt-get install -y kubectl=$VERSION 

cat <<EOF >> ~/.bashrc
source <(kubectl completion bash)
alias k=kubectl
alias k='kubectl get pod'
complete -F __start_kubectl k
EOF


pc "blue" "
#######################################\n\
## Finished Kubectl Installation  ##\n\
#######################################"

