#!/bin/bash

# Works with CEntos 8 and AWS LINUX

# Official documentation how to install 
# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/#installing-a-prebuilt-centos-rhel-package-from-the-official-nginx-repository
echo "Install Nginx"

LINUX_VERSION=$(cat /etc/system-release)

echo $LINUX_VERSION

if echo $LINUX_VERSION | grep -q "Amazon Linux release 2"
then
  OSRELEASE="7"
  sudo amazon-linux-extras install nginx1 -y
  sudo systemctl enable nginx
elif echo $LINUX_VERSION | grep -q "CentOS Linux release 8"
then
  OSRELEASE="8"
  cat > /etc/yum.repos.d/nginx.repo <<END
  [nginx-mainline]
  name=nginx mainline repo
  baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
  gpgcheck=0
  enabled=1
  module_hotfixes=true
  END
  sudo yum -y install nginx
else
  echo "$LINUX_VERSION Linux is not supported"
  exit 1
fi

nginx -v

echo "Install finished"

