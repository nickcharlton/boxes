#!/bin/bash

case $(lsb_release -cs) in
    'wheezy')
        easy_install pip
        pip install ansible
    ;;
    *)
        apt-add-repository ppa:ansible/ansible
        apt-get -qy update
        apt-get -qy install ansible
    ;;
esac
