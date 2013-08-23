#!/bin/bash

apt-get -qy install dkms
mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
unmount /mnt

rm -f /home/vagrant/VBoxGuestAdditions.iso
