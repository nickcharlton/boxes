#!/bin/bash

##
# Configure the relevant VM tools for this builder.
##

case $PACKER_BUILDER_TYPE in
    'virtualbox-iso')
        echo "Installing VirtualBox Guest Additions..."
        apt-get -qy install dkms
        mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
        sh /mnt/VBoxLinuxAdditions.run
        umount /mnt
        
        rm -f /home/vagrant/VBoxGuestAdditions.iso
    ;;
    'vmware')
        echo "Installing VMware Tools..."
        mkdir -p /mnt/cdrom
        mount -o loop /home/vagrant/linux.iso /mnt/cdrom

        cd /tmp
        tar -zxpf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
        /tmp/vmware-tools-distrib/vmware-install.pl -d

        umount /mnt/cdrom
        rm -f /home/vagrant/linux.iso
    ;;
    *)
        printf "Nothing to do for the %s builder type.\n" $PACKER_BUILDER_TYPE
    ;;
esac
