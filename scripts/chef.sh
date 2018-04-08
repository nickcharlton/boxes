#!/bin/bash

# Fetches the Chef package version and sha from the Boxes API, then installs
# the package.

set -e

boxes_api="https://boxes.io/api/v1"
platform=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
release=$(lsb_release -sr)

if [ "$platform" == "debian" ]; then
	release=$(echo "$release" | cut -d. -f1)
fi

version_url="$boxes_api/metadata/chef?platform=$platform&platform_version=$release"

echo "Determining current Chef package version..."
if ! current_version=$(curl --silent --fail "${version_url}"); then
	>&2 echo "Unable to fetch version information for $platform, $release"
	exit 1
fi

version_url=$(echo "$current_version" | python -c  \
	"import json,sys;obj=json.load(sys.stdin);print obj['url'];")
version_sha=$(echo "$current_version" | python -c \
	"import json,sys;obj=json.load(sys.stdin);print obj['sha256'];")

echo "Fetching Chef package..."
curl --silent --fail "$version_url" -o chef.deb

echo "Verifying downloaded Chef package..."
downloaded_sha=$(openssl sha256 -r chef.deb)
if [ "$version_sha *chef.deb" != "$downloaded_sha" ]; then
	>&2 echo "Unable to verify downloaded chef.deb"
	echo 2
fi

echo "Installing Chef package..."
dpkg --install chef.deb

echo "Tidying up artifacts..."
rm chef.deb
