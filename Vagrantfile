# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # Machine 1 : Web Server (Ubuntu 22.04)
  config.vm.define "web-server" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "web-server"
    web.vm.network "public_network"
    web.vm.network "private_network", ip: "192.168.56.10"
    
    # Add synced folder
    web.vm.synced_folder "./website", "/var/www/html", 
      owner: "www-data", group: "www-data"
    
    web.vm.provider "virtualbox" do |vb|
      vb.name = "DevOps-Web-Server"
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    web.vm.provision "shell", path: "scripts/provision-web-ubuntu.sh"
  end

  # Machine 2 : DB Server (CentOS 9)
  config.vm.define "db-server" do |db|
    db.vm.box = "centos/stream9"
    db.vm.hostname = "db-server"
    db.vm.network "private_network", ip: "192.168.56.20"
    db.vm.network "forwarded_port", guest: 3306, host: 3307
    
    db.vm.provider "virtualbox" do |vb|
      vb.name = "DevOps-DB-Server"
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    db.vm.provision "shell", path: "scripts/provision-db-centos.sh"
  end
end