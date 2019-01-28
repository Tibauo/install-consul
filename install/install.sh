#!/bin/bash

PROGNAME=$0

HOME_DIR=$PWD
echo "HOME_DIR=$HOME_DIR"

source $HOME_DIR/var

usage(){
cat <<EOF
Need to be sudoer or root
Please check var in folder $HOME_DIR/var. All var in this folder need exist

How to use
----------
$PROGNAME

EOF
exit 1
}


requiredInstallYum(){
  yum update -y
  yum install -y epel-release unzip wget vim
}

requiredInstallApt(){
  apt update -y
  apt install -y wget unzip vim
}

createUser(){
if [ -z $(id -u $user) ]; then
  echo "user $user doesn't exist"
  useradd -m $user -s /bin/bash
  echo "user $user created"
fi

if [ -f $path_home_user ]; then
  echo "home directory $path_home_directory for $user doesn't exist"
  usage
fi
}

installConsul(){
wget $consullink -P /tmp/
unzip /tmp/$consulzip -d /usr/local/bin
}

main(){

if [ -n "$(command -v yum)" ]; then
  echo "Yum"
  requiredInstallYum
elif [ -n "$(command -v apt-get)" ]; then
  echo "Apt"
  requiredInstallApt
else
  echo [ "don't know" ]
  usage
fi

createUser
installConsul
}

while getopts ":h" option; do
    case "${option}" in
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  usage
fi

main
