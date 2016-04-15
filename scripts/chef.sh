#!/bin/bash

# Get the Chef package version through their metadata service.
platform=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
release=$(lsb_release -sr)
version_url="https://www.opscode.com/chef/metadata?v=&prerelease=false&nightlies=false&p=$platform&pv=$release&m=x86_64"
current_version=$(curl -s "$version_url")

version_url=$(echo "$current_version" | awk '/url/{print $2}')
version_sha=$(echo "$current_version" | awk '/sha256/{print $2}')

# fetch chef
curl --insecure --location $version_url -o chef.deb

# check the file
echo "$version_sha  chef.deb" > '/tmp/chef-checksum'
shasum -a 256 -c '/tmp/chef-checksum'
if [ $? -ne 0 ]; then
    echo "Downloaded Chef package failed to checksum."
    exit 1
fi

# install
dpkg -i chef.deb

# cleanup
rm chef.deb
rm /tmp/chef-checksum
