#!/bin/bash

#install lNMP
read -p "是否安装LNMP环境？[y/n]：" yes

if [ $yes == "y" ]
then
    read -p "请选择PHP版本[5/7]：" version

    echo -e "\e[1;31m 开始安装PHP-FPM\e[0m"
    if [ $version == "7" ]
    then
        sudo apt-get install -y language-pack-en-base
        sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
        sudo apt-get update

        sudo apt-get install -y php7.1-fpm php7.1-cli php7.1-common php7.1-curl php7.1-dev \
        php7.1-gd php7.1-imap php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql \
        php7.1-soap php7.1-xml php7.1-zip php7.1-opcache 
    fi

    if [ $version == "5" ]
    then
        sudo apt-get install -y php5-fpm php5-common php5-dev php5-cli php5-mysql \
        php5-mcrypt php5-gd php5-intl php5-pgsql php5-xsl php5-curl \
        php5-json php5-imap 
    fi

    echo -e "\e[1;31m 开始安装Nginx\e[0m"
    sudo apt-get install -y nginx
    
    echo -e "\e[1;31m 开始安装Mysql\e[0m"
    sudo apt-get install -y mysql-server-5.6  mysql-client-5.6

    echo -e "\e[1;31m LNMP已正确安装\e[0m"
fi
