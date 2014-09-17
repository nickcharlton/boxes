# this installs chruby, ruby-install and a selection of rubies and is used in
# the 'ruby' special box type.

chruby_version=0.3.8
rubyinstall_version=0.4.3

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
ruby-install ruby 1.9.3
ruby-install ruby 2.0.0 -p https://gist.github.com/nickcharlton/e6af8791fda26e24ae8f.txt
ruby-install ruby 2.1.2

exit
