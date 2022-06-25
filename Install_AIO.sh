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


pc "green" "
###############################\n\
##     Java JDK Install      ##\n\
###############################"


sudo apt update
sudo apt install openjdk-11-jdk
pc "red" "
Java Version is $(java --version)
"
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

if [[ $(echo $PATH) =~ $JAVA_HOME ]]
then
  echo " already configure env PATH "
else
  PATH=$PATH:$JAVA_HOME
  export PATH=$PATH
  echo "exxport PATH=${PATH}" | tee -a ~/.bash_profile
fi


pc "green" "
####################################\n\
## Add apt repository for Jenkins ##\n\
####################################"

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -


sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'


pc "dark-gray" "
###########################\n\
## Install Jenkins       ##\n\
###########################"

sudo apt-get update
sudo apt-get install jenkins -y


servicename="jenkins"
if [ $(systemctl is-active $servicename) == "inactive" ]
then
  echo "$servicename service start ... "
  sudo systemctl start jenkins
  sudo systemctl enable jenkins
fi

pc "red" "$servicename Status : $(systemctl is-active $servicename)"

### Finish
pc "dark-gray" "
#######################################\n\
## Finished Jenkins Installation     ##\n\
#######################################"




##################################
##    awscli Installation   ##
##################################


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




##################################
##    EKSCTL   Installation   ##
##################################


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


##################################
##    Terraform  Installation   ##
##################################



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

















pc "cyan" "\n\
###############################\n\
##   Docker-compose Install   ##\n\
###############################"


sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


pc "cyan" "\n\
########################################\n\
##   Finished Docker-compose Install  ##\n\
########################################"




##################################
##    Helm       Installation   ##
##################################


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



##################################
##    Kubectl   Installation   ##
##################################



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

pc "blue" "
#######################################\n\
## Finished Kubectl Installation  ##\n\
#######################################"







## SW pkg for APT Repository 
pc "green" "
###############################\n\
## SW pkg for APT Repository ##\n\
###############################"

sudo apt-get update -y

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release


## Add Docker Repository  
pc "green" "
###############################\n\
## Add Docker Repository     ##\n\
###############################"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y


## Install Docker Enging &  Container Runtime 
pc "green" "
###################################################\n\
## Install Docker Enging & Container Runtime     ##\n\
###################################################"

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

pc "green" " Finished  Docker Installation... "

sudo usermod -aG docker $USER






pc "red" "\n\
awscli version : $(aws --version)"


pc "red" "eksctl version : $(eksctl version)"


pc "red" "\n\
terraform version : $(terraform version)"

pc "red" "Docker-compose version : $(docker-compose -version)"



pc "red" " helm version : $(helm version --short)"


pc "red" " docker version : \n\
	$(docker version | grep -iB 2 version)"

pc "red" "
Jenkins Server  :  $(curl ifconfig.me):8080 \n\
\n\
Your First Administrator password :  $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"


pc "red" "\n\n\n##  You must reboot this terminal to apply modification ##"

