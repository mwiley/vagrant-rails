# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config_path = "config/vagrant"

  config.vm.provision :shell, path: "#{config_path}/build_dependency_setup.sh"
  config.vm.provision :shell, path: "#{config_path}/git_setup.sh"

  config.vm.provision :shell, path: "#{config_path}/nodejs_setup.sh"
  config.vm.provision :shell, path: "#{config_path}/rbenv_setup.sh", privileged: false

  config.vm.provision :shell, path: "#{config_path}/imagemagick_setup.sh"
  config.vm.provision :shell, path: "#{config_path}/phantomjs_setup.sh"

  config.vm.provision :shell, path: "#{config_path}/sqlite_setup.sh"
  config.vm.provision :shell, path: "#{config_path}/postgresql_setup.sh"

  # PostgreSQL Server port forwarding
  config.vm.network "forwarded_port", host: 5432, guest: 5432

  # Rails development server port forwarding
  config.vm.network "forwarded_port", host: 3000, guest: 3000

end
