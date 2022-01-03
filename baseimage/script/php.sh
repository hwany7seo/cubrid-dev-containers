#!/bin/bash

PHP_VERSION=$1

if [ "x$PHP_VERSION" = "x56" ]; then
yum remove -y php-*
yum --enablerepo=remi-php56 install -y php php-common php-devel php-bcmath php-gd php-pdo php-pear php-mysqlnd php-mbstring php-xml php-tidy php-soap
elif [ "x$PHP_VERSION" = "x71" ]; then
yum remove -y php-*
yum --enablerepo=remi-php71 install -y php php-common php-devel php-bcmath php-gd php-pdo php-pear php-mysqlnd php-mbstring php-xml php-tidy php-soap
elif [ "x$PHP_VERSION" = "x74" ]; then
yum remove -y php-*
yum --enablerepo=remi-php74 install -y php php-common php-devel php-bcmath php-gd php-pdo php-pear php-mysqlnd php-mbstring php-xml php-tidy php-soap
else
  echo "usage: $0 <PHP_VERSION>"
  echo "support version : 56, 71, 74"
  echo "ex.) $0 56"
fi
