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


pc "red" "
Jenkins Server  :  $(curl ifconfig.me):8080 \n\
\n\
Your First Administrator password :  $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
