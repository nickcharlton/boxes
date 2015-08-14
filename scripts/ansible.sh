#!/bin/bash

case $(lsb_release -is) in
    'ubuntu')
        apt-add-repository ppa:ansible/ansible
        apt-get -qy update
        apt-get -qy install ansible
    ;;
    *)
        easy_install pip
        pip install ansible
    ;;
esac
