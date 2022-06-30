#!/bin/bash

##################################

##    Kubernetes Installation   ##

##################################


######################################################

###    Please  Input the version of K8S you want   ###

##   e.g.)  bash K8S-install-control.sh  1.21.12-00  #

######################################################

function pc(){
  nc='\033[0m' # no color

  case $1 in
	"green") COLOR='\033[0;32m';;
	"red") COLOR='\033[0;31m';;
	"*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}




read -p "Enter The Version of k8s you want  (e.g. 1.21.12-00) : " VERSION

echo "Control plane endpoint set $(hostname -i)"
CONTROL_IP=$(hostname -i)
# POD_NETWORK_CIDR = 127.16.0.0./16


##  Add Kubernetes Repository 

pc "green" "
###############################\n\
## Add Kubernetes Repository ##\n\
###############################"

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y



##  Install  K8S
pc "green" "
#######################################\n\
## Install Kubelet, kubeadm, kubectl ##\n\
#######################################"


sudo apt-get install -y kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION

pc "green" "
#######################################\n\
## Finished Kubernetes Installation  ##\n\
#######################################"

