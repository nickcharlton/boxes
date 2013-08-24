#!/bin/bash

##
# Configure the relevant VM tools for this builder.
##

case $PACKER_BUILDER_TYPE in
    'virtualbox')
        echo "Installing VirtualBox Guest Additions..."
        apt-get -qy install dkms
        mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
        sh /mnt/VBoxLinuxAdditions.run
        umount /mnt
        
        rm -f /home/vagrant/VBoxGuestAdditions.iso
    ;;
    *)
        printf "Nothing to do for the %s builder type.\n" $PACKER_BUILDER_TYPE
    ;;
esac
