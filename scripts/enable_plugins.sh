#!/bin/bash

printf "************************************************\n"
echo "                 enable plugins                "
printf "************************************************\n"

LIBRARY='library'

echo "Does your koha-instance have a custom name (y/n)"
read choice

case $choice in
    y | Yes | yes | Y | YES)
        #echo "hey there" 
        echo "here is a list of the instances found "
        sudo koha-list
        echo "What is your library's name "
        read LIBRARY
        ;;
    n | No | no | NO | N)
        echo "Oh my foot"
        ;;    
esac

ADRESS=/etc/koha/sites/$LIBRARY/koha-conf.xml

if test -f "$ADRESS"; then
    echo "That file actually exists was prepared correctly"
    printf "Change :  \n <enable_plugins>0</enable_plugins> \n from 0 to 1 thus enabling the plugins"
    nano +281 $ADRESS
else
    echo "Something went wrong"    
fi   

echo "Ill just go on and restart the necessary things for you"

chmod +x restart_koha.sh && ./restart_koha.sh