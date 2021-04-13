#!/bin/bash 

echo "**********************"
echo "This will set up and install koha "
echo "**********************"
echo "It might not be perfect, but it will get you started"

#defaults
LIBRARY_NAME='library'


#some methods
upgrade(){
    sudo apt update 
    sudo apr upgrade
    sudo apt clean
}

mysql(){
    sudo apt install mysql-server 
}

maria_db(){
     sudo apt install mariadb-server
}

apache_modules(){
    sudo a2enmod rewrite
    sudo a2enmod cgi
    sudo service apache2 restart
}

enable_modules(){
    sudo a2enmod deflate
    sudo a2ensite library
    sudo service apache2 restart
}

#prepare your system 
upgrade

#Add a Koha Community Repository
echo deb http://debian.koha-community.org/koha stable main | sudo tee /etc/apt/sources.list.d/koha.list

#Add the key in gpg.asc to your APT trusted keys to avoid warning messages on installation:
wget -O- https://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -

#upgrade to reflect the changes  
upgrade

#install koha-common
sudo apt install koha-common

CONF=/etc/koha/koha-sites.conf
if test -f "$CONF"; then
    echo "$CONF was prepared correctly"
    echo "Update the details accordingly"
    nano +3 $CONF
else
    echo "Something went wrong"    
fi    

#which database to install
printf '(1) Install maria-db server  \n(2) Install mysql-server \n(3) Already have one installed\n'
read  num


if [ $num -eq 1 ] 
then
echo "you choose maria"
maria_db
elif [ $num -eq 2 ]
then
echo "you choose mysql"
mysql
elif [[ $num -eq 3 ]]
then
echo "You already have one installed"
else
echo "now thats just incorrect"
fi
   
#apache modules 
apache_modules

#create koha instance 
echo "Enter a library name "
read LIBRARY_NAME

sudo koha-create --create-db $LIBRARY_NAME

PORTS=/etc/apache2/ports.conf
if test -f "$PORTS"; then
    echo "$PORTS was prepared correctly"
    echo "Update the details accordingly CONSIDERING A PORT FOR OPAC AND THE STAFF INTERFACE"
    nano  $PORTS
else
    echo "Something went wrong"    
fi  

#open the designated ip adress and usthese credentials 
echo "Credentials"
sudo xmlstarlet sel -t -v 'yazgfs/config/pass' /etc/koha/sites/library/koha-conf.xml;echo