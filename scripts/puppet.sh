#!/bin/bash

# see: https://docs.puppet.com/puppet/latest/puppet_platform.html

# determine the os release
os_release=$(lsb_release -cs)

# configure the puppet package sources
wget "https://apt.puppet.com/puppet5-release-$os_release.deb"
dpkg -i "puppet5-release-$os_release.deb"
apt-get -q update
