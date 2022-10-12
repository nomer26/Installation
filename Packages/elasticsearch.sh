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

#OSTYPE=$(cat /etc/*release | egrep '^ID=' | cut -d= -f2)
#echo $OSTYPE

INSTALLER=

while [ -z $INSTALLER ]
do
  read -p "Set How to install ES (e.g. tar.gz, apt, yum .. ) : " INSTALLER
done

if [[ "$INSTALLER" == "tar.gz" ]];
then

  pc "magenta" "\n\
  ###############################\n\
  ## Elastic Search Install    ##\n\
  ###############################"

  if [ "$VERSION" -eq 8 ];
  then
  
    curl -O -L https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.4.3-linux-x86_64.tar.gz

    tar zxf elasticsearch-8.4.3-linux-x86_64.tar.gz

    mv elasticsearch-8.4.3-linux-x86_64.tar.gz es-8

  elif [ "$VERSION" -eq 7 ];
  then
    curl -O -L https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.17.1-linux-x86_64.tar.gz

    tar zxf elasticsearch-7.17.1-linux-x86_64.tar.gz

    mv elasticsearch-7.17.1-linux-x86_64.tar.gz es-7
  else
    echo "Not Support"
  fi

  pc "magenta" "\n\
  ############################################\n\
  ##     Finished  ElasticSearch Install    ##\n\
  ############################################"
fi



if [[ "$INSTALLER" == "ubuntu" ]];
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

if [[ "$INSTALLER" == "centos" ]];
then

   pc "magenta" "\n\
  ###############################\n\
  ## Elastic Search Install    ##\n\
  ###############################"
  
  sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
  
  sudo bash -c 'cat <<EOF > /etc/yum.repos.d/elasticsearch.repo
[elasticsearch]
name=Elasticsearch repository for '${VERSION}'.x packages
baseurl=https://artifacts.elastic.co/packages/'${VERSION}'.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF'

  sudo yum install --enablerepo=elasticsearch elasticsearch -y

  pc "magenta" "\n\
  ############################################\n\
  ##     Finished  ElasticSearch Install    ##\n\
  ############################################"
fi 

