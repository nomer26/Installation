#!/bin/bash

#####################################
##   ElasticSearch Installation    ##
#####################################


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
  read -p "Enter The Version of elasticsearch you want (e.g. 7, 8) : " VERSION
done

## Add ES repository

OSTYPE=$(awk -F = 'NR==4 {print $2;}' /etc/*release)


if [[ "$OSTYPE" == "\"ubuntu\"" ]];
then
  
  pc "magenta" "\n\
  ###############################\n\
  ## Elastic Search Install    ##\n\
  ###############################"
  
  wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
  
  sudo apt-get install apt-transport-https -y
  
  echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/${VERSION}.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-${VERSION}.x.list
  
  sudo apt-get update && sudo apt-get install elasticsearch
  
  pc "magenta" "\n\
  ############################################\n\
  ##     Finished  ElasticSearch Install    ##\n\
  ############################################"
fi

if [[ "$OSTYPE" == "\"centos\"" ]];
then

   pc "magenta" "\n\
  ###############################\n\
  ## Elastic Search Install    ##\n\
  ###############################"
  
  sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
  
  sudo bash -c 'cat <<EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch]
name=Elasticsearch repository for ${VERSION}.x packages
baseurl=https://artifacts.elastic.co/packages/${VERSION}.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF'

  sudo yum install --enablerepo=elasticsearch elasticsearch -y

  pc "magenta" "\n\
  ############################################\n\
  ##     Finished  ElasticSearch Install    ##\n\
  ############################################"
fi 

