#!/bin/bash

# Install Chef
# see: http://stackoverflow.com/a/14738173/83386
gem install net-ssh -v 2.2.2 --no-ri --no-rdoc
gem install net-ssh-gateway -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
gem install net-ssh-multi -v 1.1.0 --no-ri --no-rdoc --ignore-dependencies
gem install chef -v 11.16.4 --no-ri --no-rdoc
