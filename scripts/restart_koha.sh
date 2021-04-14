#!/bin/bash

enable_modules(){
    sudo a2enmod deflate
    sudo a2ensite library
    sudo service apache2 restart
}

apache_modules(){
    sudo a2enmod rewrite
    sudo a2enmod cgi
    sudo service apache2 restart
}

memcached_refresh(){
    Restart Memcached
    sudo service memcached restart
}

enable_modules
apache_modules
memcached_refresh