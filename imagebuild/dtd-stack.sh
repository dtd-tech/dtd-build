#!/bin/bash

# Script to install the LAMP stack on Ubuntu 14.04.x

# We're assuming previous steps have performend an update
export DEBIAN_FRONTEND=noninteractive

# install apache
apt-get -q -y install apache2 apache2utils


# Install mysql server
apt-get -q -y install mysql-server
# set root password to 'dtd'
mysqladmin -u root password dtd

# Install and configure php
apt-get install -q -y php5 php5-mysql php-cli php5-gd php5-mcrypt php5-curl apc
