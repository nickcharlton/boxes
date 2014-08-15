#!/bin/bash

apt-add-repository ppa:ansible/ansible
apt-get -qy update
apt-get -qy install ansible
