#!/usr/bin/env bash

echo "=== Begin Vagrant Provisioning using 'config/vagrant/phantomjs_setup.sh'"

if [ -z `which phantomjs` ]; then
  apt-get -y -qq update
  apt-get -y -qq install phantomjs
fi

echo "=== End Vagrant Provisioning using 'config/vagrant/phantomjs_setup.sh'"
