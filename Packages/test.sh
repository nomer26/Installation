#!/bin/bash


OSTYPE=$(awk -F = 'NR==4 {print $2;}' /etc/*release)

echo $OSTYPE

if [ "$OSTYPE" = "ubuntu" ];
then
  echo "ubuntu";
elif [ "$OSTYPE" = "\"centos\"" ];
then 
  echo "centos";
else
  echo "extra";
fi
