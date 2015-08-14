#!/bin/bash

# see: http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

# determine the os release
os_release=$(lsb_release -cs)

# configure the puppet package sources
wget http://apt.puppetlabs.com/puppetlabs-release-$os_release.deb
dpkg -i puppetlabs-release-$os_release.deb
apt-get -q update

# install puppet
apt-get install -qy puppet
