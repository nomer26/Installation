#!/bin/bash


## Network Plugin
pc "green" "
#######################################\n\
##       Network Plugins             ##\n\
#######################################\n\n\n"

read -p "Enter Network Plugin .. (e.g. 'flanneld','calico'...) if you want skip [ENTER] : " NET_PLUGIN

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

pc "green" "Finished Conf  Network Plugin...  "
