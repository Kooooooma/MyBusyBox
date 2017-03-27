#!/bin/bash
########################################################
#                                                      #
# This is a script for control my local docker         #
# environment on Ubuntu 14.04                          #
#                                                      #
# Koma <komazhang@foxmail.com>                         #
#                                                      #
########################################################

echo "##############################";
echo "# Koma local Docker 环境管理 #"
echo "# 1 启动Docker环境           #"
echo "# 2 关闭Docker环境           #"
echo "# 3 重启Docker环境           #"
echo "##############################";
read -p "请输入对应操作编号：" op

mysql_server_name="dbserver"
phpmyadmin_name="phpmyadmin"
ticket_name="easemob-tickets"

function startDocker()
{
    ##启动mysql docker
    sudo docker run -d --rm -e MYSQL_ROOT_PASSWORD=123456 --name $1 mysql

    ##启动phpmyadmin docker
    sudo docker run --rm -d -e SERVER_NAME=www.koma.org -v /data/www/local:/var/www/html --link $1 --name $2 docker-lnp

    ##启动工单系统docker
    sudo docker run --rm -d -e SERVER_NAME=www.emticket.org -v /data/www/emticket:/var/www/html --link $1 --name $3 docker-lnp
}

function stopDocker()
{
    sudo docker stop $3 $2 $1
}

function restartDocker()
{
    stopDocker $1 $2 $3
    startDocker $1 $2 $3
}

case $op in
    1)
        startDocker ${mysql_server_name} ${phpmyadmin_name} ${ticket_name}
        exit 0
        ;;
    2)
        stopDocker ${mysql_server_name} ${phpmyadmin_name} ${ticket_name}
        exit 0
        ;;
    3)
        restartDocker ${mysql_server_name} ${phpmyadmin_name} ${ticket_name}
        exit 0
        ;;
    *)
        echo "Exit";
        exit 0
        ;;
esac

