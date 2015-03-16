#!/usr/bin/env bash

echo "=== Begin zsh Provisioning using 'config/vagrant/zsh_setup.sh'"

sudo apt-get -y -qq install zsh
sudo chsh -s /bin/zsh vagrant
zsh

echo "=== End zsh Provisioning using 'config/vagrant/zsh_setup.sh'"
