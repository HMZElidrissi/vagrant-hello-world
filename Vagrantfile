# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  config.vm.define "web-server" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server"
    web.vm.network "public_network"
    
    web.vm.provider "virtualbox" do |vb|
      vb.name = "DevOps-Web-Server"
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    # Use external script
    web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end
end

