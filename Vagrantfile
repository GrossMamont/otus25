# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.define "log" do |log|
    log.vm.network "private_network", ip: "192.168.56.11", virtualbox__intnet: "net1"
    log.vm.hostname = "log"
    log.vm.provision "shell", path: "log_script.sh"
  end
  
  config.vm.define "web" do |web|
    web.vm.network "private_network", ip: "192.168.56.10", virtualbox__intnet: "net1"
    web.vm.hostname = "web"
    web.vm.network "forwarded_port", guest: 80, host: 80
    web.vm.provision "shell", path: "web_script.sh"

    web.vm.provision "web_nginx_sshd", type: "ansible" do |ansible|
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "playbook_web.yml"
    end
    web.vm.provision "shell", path: "web_postscript.sh"
  end

  config.vm.define "client" do |client|
    client.vm.network "private_network", ip: "192.168.56.12", virtualbox__intnet: "net1"
    client.vm.hostname = "client"
    client.vm.provision "shell", path: "client_script.sh"
  end

end
