#!/bin/bash

apt-get install -qy postgresql postgresql-contrib libpq-dev postgresql-client

POSTGRES_VERSION=$(dpkg-query -W -f='${Depends}' postgresql |
    sed 's/\postgresql-//g')

# allow connections on the local network
cat << EOF >> /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf
# Allow connections on the 192.168.*.* local/VM network
host    all             all             192.168.0.0/16          md5
host    all             all             172.16.0.0/12           md5
EOF

# enable listening on all addresses
sed -i.bak "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$POSTGRES_VERSION/main/postgresql.conf

# restart postgres
service postgresql restart

# create a local user
# createuser --createdb --super --pwprompt -e vagrant (with a password of 'vagrant')
su postgres -c "psql -c \"CREATE ROLE vagrant PASSWORD 'md5ce5f2d27bc6276a03b0328878c1dc0e2' SUPERUSER CREATEDB NOCREATEROLE INHERIT LOGIN;\""

# create a history file
touch ~/.psql_history
