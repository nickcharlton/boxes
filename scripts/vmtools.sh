#!/bin/bash

##
# Configure the relevant VM tools for this builder.
##

distribution=$(lsb_release -si)
version=$(lsb_release -sr)
major_version=$(echo "$version" | awk -F . '{print $1}')

case $PACKER_BUILDER_TYPE in
    'virtualbox-iso')
        echo "Installing VirtualBox Guest Additions..."
        apt-get -qy install dkms
        mount -o loop /home/vagrant/VBoxGuestAdditions.iso /mnt
        sh /mnt/VBoxLinuxAdditions.run
        umount /mnt

        rm -f /home/vagrant/VBoxGuestAdditions.iso
    ;;
    'vmware-iso')
				if [ "$distribution" = 'Ubuntu' ]; then
					if [ "$major_version" -le "19" ]; then
						echo "Installing VMware Tools..."
						apt-get -qy install fuse
						mkdir -p /mnt/cdrom
						mount -o loop /home/vagrant/linux.iso /mnt/cdrom

						cd /tmp
						tar -zxpf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/
						/tmp/vmware-tools-distrib/vmware-install.pl --force-install --default

						umount /mnt/cdrom
						rm -f /home/vagrant/linux.iso
					else
						echo "Skipping installing VMware Tools because open-vm-tools works..."
					fi
				fi
    ;;
    *)
        printf "Nothing to do for the %s builder type.\n" $PACKER_BUILDER_TYPE
    ;;
esac
