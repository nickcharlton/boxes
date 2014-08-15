#!/bin/bash

# From source
#git clone git://github.com/ansible/ansible.git
#cd ./ansible
#source ./hacking/env-setup

# PIP installer
#sudo easy_install pip
#sudo pip install ansible

# RPM installer
#sudo yum install ansible

# Apt installer
apt-add-repository ppa:ansible/ansible
apt-get -qy update
apt-get -qy install ansible
