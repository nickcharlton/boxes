#!/bin/sh

##
# Post install configuration, preparing the box for usage
#
# Originally based upon Mitchell's old basebox example
##

# mark the build time
date > /etc/vagrant_box_build_time

# update the apt cache and packages
case $(lsb_release -cs) in
    'precise')
        apt-get clean
        rm -rf /var/lib/apt/lists/*
        apt-get clean
    ;;
    *)
    ;;
esac

apt-get -qy update
apt-get -qy upgrade

# install some oft used packages
apt-get -qy install linux-headers-$(uname -r) build-essential \
  zlib1g-dev libssl-dev

# configure password-less sudo
usermod -a -G sudo vagrant
echo "%vagrant ALL=NOPASSWD:ALL" > /tmp/vagrant
mv /tmp/vagrant /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# install the vagrant-provided ssh keys
mkdir -pm 700 /home/vagrant/.ssh
curl -Lo /home/vagrant/.ssh/authorized_keys \
  'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

disable_automatic_udev_rules() {
	echo "Disabling automatic udev rules for network interfaces..."

	# source: http://6.ptmc.org/164/
	rm -f /etc/udev/rules.d/70-persistent-net.rules
	ln -s /dev/null /etc/udev/rules.d/70-persistent-net.rules
	rm -f /lib/udev/rules.d/75-persistent-net-generator.rules
	rm -rf /dev/.udev/ /var/lib/dhcp/*
}

disable_predictable_interface_names() {
	echo "Disabling predictable interface names..."

	sed -i 's/en[[:alnum:]]*/eth0/g' /etc/network/interfaces
	sed -ie 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 \1"/g' /etc/default/grub
	update-grub
}

configure_netplan() {
	echo "Creating DHCP netplan config for eth0..."

	cat <<-EOF >/etc/netplan/01-netcfg.yaml;
	network:
    version: 2
    ethernets:
      eth0:
        dhcp4: true
	EOF
}

distribution=$(lsb_release -si)
version=$(lsb_release -sr)
major_version=$(echo "$version" | awk -F . '{print $1}')

if [ "$distribution" = 'Ubuntu' ]; then
	if [ "$major_version" -ge "16" ]; then
		disable_predictable_interface_names
	fi

	if [ "$major_version" -ge "18" ]; then
		configure_netplan
	fi
elif [ "$distribution" = 'Debian' ]; then
	if [ "$major_version" -ge "8" ]; then
		disable_predictable_interface_names
	fi
fi

disable_automatic_udev_rules

# clean up any artifacts
rm -f /home/vagrant/shutdown.sh
