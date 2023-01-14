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
	"light-cyan") COLOR='\033[0;96m';; 
	"dark-gray") COLOR='\033[1;30m';;
	"*") COLOR='\033[0m';;
  esac
  echo -e "${COLOR} $2 ${nc}"
}


pc "yellow" "\n\
###############################\n\
##     AWS CLI  Install      ##\n\
###############################"


#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#sudo apt install unzip -y
#unzip awscliv2.zip
#sudo ./aws/install

sudo apt update -y
sudo apt install awscli -y


pc "yellow" "\n\
#########################################\n\
##     Finished  AWS CLI  Install      ##\n\
#########################################"



pc "light-cyan" "
#####################\n\
## Install EKSctl ##\n\
#####################"


curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


pc "light-cyan" "
#######################################\n\
## Finished EKSctl Installation     ###\n\
#######################################"



pc "light-cyan" "\n\
###############################\n\
##     Helm     Install      ##\n\
###############################"


curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2


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



KUBE_VERSION=$(printenv KUBE_VERSION)

#while [ -z $VERSION ]
#do
#  read -p "Enter The Version of kubectl you want  (e.g. 1.21.12-00) : " VERSION
#done
##  Add Kubernetes Repository

pc "green" "
###############################\n\
## Add Kubernetes Repository ##\n\
###############################"

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y

pc "blue" "
#####################\n\
## Install kubectl ##\n\
#####################"


if [[ $KUBE_VERSION == '' ]];
then
  sudo apt-get install -y kubectl
else
  sudo apt-get install -y kubectl=$KUBE_VERSION
fi

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



pc "green" "
###############################\n\
## Install  Ansible          ##\n\
###############################"

sudo apt update
sudo apt install ansible -y


pc "green" "
#######################################\n\
## Finished Ansible Installation  ##\n\
#######################################"




pc "red" "\n\
#############  AWS VERSION   ###############\n\
AWS CLI version : $(aws --version)"


pc "red" "\n\
#############  EKSCTL VERSION   ###############\n\
Eksctl version : $(eksctl version)"

pc "red" "\n\
#############  HELM VERSION   ###############\n\
helm version : $(helm version --short)"

pc "red" "\n\
#############  Kubectl VERSION   ###############\n\
kubectl version : $(kubectl version --short)"


pc "red" "\n\
#############  TERRAFORM VERSION   ###############\n\
Terraform version : $(terraform version)"


pc "red" "\n\
#############  ANSIBLE VERSION   ###############\n\
ansible version : $(ansible --version)"


