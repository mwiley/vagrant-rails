#!/usr/bin/env bash

echo "=== Begin Vagrant Provisioning using 'config/vagrant/imagemagick_setup.sh'"

if [ -z `which convert` ]; then
  apt-get -y -qq update
  apt-get -y -qq install imagemagick
fi

echo "=== End Vagrant Provisioning using 'config/vagrant/imagemagick_setup.sh'"
