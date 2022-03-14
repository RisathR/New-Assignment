#!/bin/bash
s3bucket="upgrad-risath"
name="risath"

#Update of the package details and package list
sudo apt update -y

#To install AWSCLI
sudo apt install awscli

#Apache2 package install
sudo apt-get install apache2

#To ensure that apache2 is enabled and service is running
service apache2 status

#To restart Apache2
service apache2 restart

#To create a tar archive file
timestamp=$(date '+%d%m%Y-%H%M%S')
cd /var/log/apache2

tar czf /tmp/${name}-httpd-logs-${timestamp}.tar *.log
if [[ -f /tmp/${name}-httpd-logs-${timestamp}.tar ]];
then
	aws s3 cp /tmp/${name}-httpd-logs-${timestamp}.tar s3://${s3bucket}/${name}-httpd-logs-${timestamp}.tar
fi
