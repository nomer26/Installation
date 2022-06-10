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




read -p "Enter The Version of k8s you want : " VERSION

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


##  Cluster Init
pc "green" "
#######################################\n\
##       Cluster  Init               ##\n\
#######################################"


sudo kubeadm init 


pc "green" "
 ^   ^   ^   ^   ^   ^   ^   ^   ^   ^ 
^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ 
 |   |   |   |   |   |   |   |   |   |

	KUBEADM    JOIN  TOKEN\n"


pc "green" "Let's go to configure The Worker nodes with the above information"

## kubectl setting
pc "green" "
#######################################\n\
##       kubectl   setting           ##\n\
#######################################"

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config


## Network Plugin
pc "green" "
#######################################\n\
##       Network Plugins             ##\n\
#######################################\n\n\n"

read -p "Enter Network Plugin .. (e.g. 'flanneld','calico'...) if you want skip [ENTER] " NET_PLUGIN

if [[ $NET_PLUGIN == "flanneld" ]]
then
	kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
elif [[ $NET_PLUGIN == "calico" ]]
then
	kubectl create -f https://docs.projectcalico.org/manifests/calico.yaml
elif [[ $NET_PLUGIN == "weave" ]]
then
	kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
	echo "Note: If using the Weave CNI Plugin from a prior full install of Weave Net with your cluster, you must first uninstall it before applying the Weave-kube addon. Shut down Kubernetes, and on all nodes perform the following:\n
	'weave reset'\n
	Remove any separate provisions you may have made to run Weave at boot-time, e.g. systemd units\n
	'rm /opt/cni/bin/weave-*'"
elif [[ $NET_PLUGIN == "" ]]
then
	pc "red" "... OK"
else
	pc "red" "Sorry.. Please install it seperately"
fi

pc "green" "Finished Control Node Conf...  "













