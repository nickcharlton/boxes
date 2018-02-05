#!/bin/sh

# this installs chruby, ruby-install and a selection of rubies and is used in
# the 'ruby' special box type.

chruby_version=0.3.9
rubyinstall_version=0.6.1

# install chruby
wget -O chruby-$chruby_version.tar.gz https://github.com/postmodern/chruby/archive/v$chruby_version.tar.gz
tar -xzvf chruby-$chruby_version.tar.gz
cd chruby-$chruby_version/
make install

# configure system-wide
cat << 'EOF' > /etc/profile.d/chruby.sh
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
fi
EOF

# install ruby-install
wget -O ruby-install-$rubyinstall_version.tar.gz https://github.com/postmodern/ruby-install/archive/v$rubyinstall_version.tar.gz
tar -xzvf ruby-install-$rubyinstall_version.tar.gz
cd ruby-install-$rubyinstall_version/
make install

# install a set of recent MRI Rubies.
ruby-install ruby 2.1.10
ruby-install ruby 2.2.9
ruby-install ruby 2.3.6
ruby-install ruby 2.4.3
ruby-install ruby 2.5.0

# update gems and install bundler
source /usr/local/share/chruby/chruby.sh
for ruby in `chruby`; do
    chruby-exec $ruby -- gem install bundler
done

exit
