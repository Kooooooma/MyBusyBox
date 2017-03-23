#!/bin/bash
########################################################
#                                                      #
# This is a script for clean php7 environment          #
# Ubuntu 14.04                                         #
#                                                      #
# Koma <komazhang@foxmail.com>                         #
#                                                      #
########################################################

sudo apt-get remove --purge php7*
sudo apt-get autoremove
sudo apt-get update 
