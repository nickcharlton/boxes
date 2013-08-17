#!/bin/bash

# see: http://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html

# configure the puppet package sources
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get -q update

# install puppet
apt-get install -qy puppet
