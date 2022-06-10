#!/bin/bash

##################################

##    Kubernetes Installation   ##

##################################





##  Add Kubernetes Repository 

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y



##  Install  K8S


sudo apt-get install -y kubelet=$1 kubeadm=$1 kubectl=$1


