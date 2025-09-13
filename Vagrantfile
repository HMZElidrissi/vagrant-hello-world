# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  # Single machine for testing
  config.vm.define "web-server" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server"
    
    # Basic network - just public for now
    web.vm.network "public_network"
    
    # VM settings
    web.vm.provider "virtualbox" do |vb|
      vb.name = "DevOps-Web-Server"
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    # Simple inline provisioning for testing
    web.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y nginx
      systemctl start nginx
      systemctl enable nginx
      echo "<h1>Vagrant Web Server Works!</h1>" > /var/www/html/index.html
    SHELL
  end
end

