#!/bin/bash

##
# Purge unnecessary data from the image to keep it small.
#
# Based on: https://gist.github.com/adrienbrault/3775253
##

# tidy up DCHP leases
echo "Cleaning up dhcp..."
rm /var/lib/dhcp/*

# make sure Udev doesn't block our network
# except on systemd systems where this isn't used
# http://6.ptmc.org/?p=164
case $(lsb_release -cs) in
    "wily" | "xenial" | "yakkety")
    ;;
    *)
    echo "Cleaning up udev..."
    rm /etc/udev/rules.d/70-persistent-net.rules
    mkdir /etc/udev/rules.d/70-persistent-net.rules
    rm -rf /dev/.udev/
    rm /lib/udev/rules.d/75-persistent-net-generator.rules
    ;;
esac

# clean up apt
echo "Cleaning up apt..."
apt-get -qy autoremove
apt-get clean -qy
apt-get autoclean -qy

# nuke the bash history
echo "Removing bash history..."
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# clean up the logs
echo "Cleaning up logs..."
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# zero any and all free space
echo "Cleaning free space..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# whiteout root
echo "Cleaning up /..."
#count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`; 
dd if=/dev/zero of=/tmp/whitespace bs=1024;
rm /tmp/whitespace;
  
# whiteout /boot
echo "Cleaning up /boot..."
#count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`;
dd if=/dev/zero of=/boot/whitespace bs=1024;
rm /boot/whitespace;

# whiteout the swap
echo "Cleaning up swap partitions..."
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart;
dd if=/dev/zero of=$swappart;
mkswap $swappart;
swapon $swappart;
