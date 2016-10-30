#!/bin/bash

apt-get -qy install python-setuptools python-dev

case $(lsb_release -is) in
    'ubuntu')
        apt-add-repository ppa:ansible/ansible
        apt-get -qy update
        apt-get -qy install ansible
    ;;
    *)
        apt-get -qy install libffi-dev
        easy_install pip
        pip install ansible
    ;;
esac
