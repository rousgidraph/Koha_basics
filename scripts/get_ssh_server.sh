#!/bin/bash 

echo "************************************"
echo "open ssh server ii installation"
echo "************************************"

#check if already exists
#output=`sudo service ssh status`


#install 
sudo apt-get install openssh-server ii.
#test on local host 

sudo service ssh status

ssh localhost






echo "We are done here. Happy doing what you are doing"