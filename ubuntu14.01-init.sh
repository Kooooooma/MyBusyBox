#!/bin/bash
########################################################
#                                                      #
# This is a script for init Ubuntu 14.04 environment.  #
#                                                      #
# Koma <komazhang@foxmail.com>                         #
#                                                      #
########################################################

read -p "请确认是否已经切换软件源？[y/n]：" yes

if [ $yes == "n" ]
then
    exit 0
fi

echo -e "\e[1;31m 开始安装必要工具\e[0m"
#install common untils
sudo apt-get install -y vim git axel curl autoconf

#install chrome
echo -e "\e[1;31m 开始安装Chrome\e[0m"
sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y google-chrome-stable
echo -e "\e[1;31m Chrome已正确安装\e[0m"

#install wps
echo -e "\e[1;31m 开始安装WPS\e[0m"
wget http://kdl.cc.ksosoft.com/wps-community/download/a21/wps-office_10.1.0.5672~a21_amd64.deb
sudo dpkg -i wps-office_10.1.0.5672~a21_amd64.deb
sudo rm wps-office_10.1.0.5672~a21_amd64.deb
echo -e "\e[1;31m WPS已正确安装\e[0m"

#install sogou pinyin
echo -e "\e[1;31m 开始安装搜狗拼音\e[0m"
sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update

sudo apt-get install -y fcitx
wget http://cdn2.ime.sogou.com/dl/index/1475147394/sogoupinyin_2.1.0.0082_amd64.deb?st=C8U8UC90QgxxJDZEBWisgw&e=1486656728&fn=sogoupinyin_2.1.0.0082_amd64.deb
sudo dpkg -i sogoupinyin_2.1.0.0082_amd64.deb?st=C8U8UC90QgxxJDZEBWisgw
sudo rm sogoupinyin_2.1.0.0082_amd64.deb?st=C8U8UC90QgxxJDZEBWisgw
echo -e "\e[1;31m 搜狗拼音已经正确安装，不要忘记重启之后去添加O(∩_∩)O哈！\e[0m"
sleep 2

#install subline-text
echo -e "\e[1;31m 开始安装Subline text\e[0m"
wget https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
sudo dpkg -i sublime-text_build-3126_amd64.deb 
sudo rm sublime-text_build-3126_amd64.deb
echo -e "\e[1;31m Subline text已正确安装\e[0m"

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

#install Docker
echo -e "\e[1;31m 开始安装Docker\e[0m"
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y apt-transport-https software-properties-common ca-certificates
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"

sudo apt-get update
sudo apt-get -y install docker-engine

echo -e "\e[1;31m 指定docker源到阿里云\e[0m"
#避免echo x >时失败
echo "DOCKER_OPTS=\"--registry-mirror=https://au6cc8gq.mirror.aliyuncs.com\"" | sudo tee -a /etc/default/docker
sudo service docker restart

echo -e "\e[1;31m 开始安装Docker-compose\e[0m"
sudo curl -L https://github.com/docker/compose/releases/download/1.11.0/docker-compose-`uname -s`-`uname -m` -o docker-compose
sudo mv docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "\e[1;31m Docker安装完成\e[0m"

#install java
echo -e "\e[1;31m 开始安装java8，耐心等待，比较慢。。。\e[0m"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jre
sudo apt-get install -y openjdk-8-jdk

#install phpstorm
echo -e "\e[1;31m 开始安装phpstorm\e[0m"
wget https://download.jetbrains.8686c.com/webide/PhpStorm-2016.3.2.tar.gz
tar -xzvf PhpStorm-2016.3.2.tar.gz
sudo rm PhpStorm-2016.3.2.tar.gz
sudo mv PhpStorm-163.10504.2/ /usr/local/phpstrom 
(
cat <<EOF
[Desktop Entry]
Type=Application
Version=1.0
Name=phpstorm
Icon=/usr/local/phpstrom/bin/phpstorm.png
Exec=/usr/local/phpstrom/bin/phpstorm.sh
Categories=Application;
Terminal=false
EOF
) | sudo tee -a /usr/share/applications/phpstorm.desktop
sudo chmod 777 /usr/share/applications/phpstorm.desktop

#安装完成，准备重启系统
read -p "Reboot now?[y/n]: " yes
if [ $yes == "y" ]
then
    sudo reboot
fi

exit 0
######END
