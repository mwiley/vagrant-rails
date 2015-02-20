#!/usr/bin/env bash

echo "=== Begin Vagrant Provisioning using 'config/vagrant/sqlite_setup.sh'"

sudo apt-get update
sudo apt-get install -y sqlite3 libsqlite3-dev

echo "=== End Vagrant Provisioning using 'config/vagrant/sqlite_setup.sh'"
