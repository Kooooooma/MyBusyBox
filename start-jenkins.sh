#!/bin/bash

sudo docker stop jenkins

sudo docker run --rm --name jenkins -p 8899:8080 -p 50000:50000 -u root -v /data/www/jenkins:/var/jenkins_home jenkins
