#!/bin/sh -e

echo "=== Begin Vagrant Provisioning using 'config/vagrant/postgresql_setup.sh'"

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=postgres_db
APP_DB_PASS=$APP_DB_USER

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=vagrant_dev
APP_DB_TEST_NAME=vagrant_test

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.4

###########################################################
# Changes below this line are probably not necessary
###########################################################
print_db_usage () {
  echo "PostgreSQL has been setup and can be accessed on your local machine on the forwarded port (default: 15432)"
  echo "  Host: localhost"
  echo "  Port: 15432"
  echo "  Database: $APP_DB_NAME"
  echo "  Username: $APP_DB_USER"
  echo "  Password: $APP_DB_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost <DATABASE_NAME>"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$APP_DB_USER:$APP_DB_PASS@localhost:15432/<DATABASE_NAME>"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost -p 15432 <DATABASE_NAME>"
}

export DEBIAN_FRONTEND=noninteractive

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  echo ""
  print_db_usage
  exit
fi

# Add PG apt repo:
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Add PG repo key:
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
sudo apt-get update -qq

apt-get -y -qq install "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION"
apt-get -y -qq install libpq-dev # For building ruby 'pg' gem

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "local    all             all                                  md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
service postgresql restart

cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER PASSWORD '$APP_DB_PASS';
ALTER USER $APP_DB_USER CREATEDB;
EOF

cat << EOF | su - postgres -c psql
-- Create the databases:
CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
                                   LC_COLLATE='en_US.utf8'
                                   LC_CTYPE='en_US.utf8'
                                   ENCODING='UTF8'
                                   TEMPLATE=template0;
EOF

cat << EOF | su - postgres -c psql
CREATE DATABASE $APP_DB_TEST_NAME WITH OWNER=$APP_DB_USER
                                   LC_COLLATE='en_US.utf8'
                                   LC_CTYPE='en_US.utf8'
                                   ENCODING='UTF8'
                                   TEMPLATE=template0;
EOF

# Tag the provision time:
date > "$PROVISIONED_ON"

echo "Successfully created PostgreSQL dev virtual machine."
echo ""
print_db_usage

echo "=== End Vagrant Provisioning using 'config/vagrant/postgresql_setup.sh'"
