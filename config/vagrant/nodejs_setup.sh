#!/usr/bin/env bash

echo "=== Begin Vagrant Provisioning using 'config/vagrant/nodejs_setup.sh'"

if [ -z `which nodejs` ]; then
  apt-get -y -qq update
  apt-get -y -qq install node npm
fi

echo "=== End Vagrant Provisioning using 'config/vagrant/nodejs_setup.sh'"
