#!/usr/bin/env bash

echo "=== Begin Vagrant Provisioning using 'config/vagrant/sqlite_setup.sh'"

sudo apt-get -y -qq update
sudo apt-get -y -qq install sqlite3 libsqlite3-dev

echo "=== End Vagrant Provisioning using 'config/vagrant/sqlite_setup.sh'"
