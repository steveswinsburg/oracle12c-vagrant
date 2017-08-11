# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/centos-7.2"

  #config.vm.box_check_update = true
  config.vbguest.auto_update = false
  #config.vbguest.auto_reboot = true

  # workaround the vagrant 1.8.5 bug
  config.ssh.insert_key = false

  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 6000
    v.cpus = 2
    v.name = "oracle12c-vagrant"
    v.customize ["modifyvm", :id, "--cableconnected1", "on"]
    v.customize ["modifyvm", :id, "--ioapic", "on"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
  end

  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 1521, host: 1521

  # Provision everything on the first run
  config.vm.provision "shell", path: "scripts/install.sh"

  config.vm.synced_folder ".", "/vagrant"
  config.vm.synced_folder "./oradata", "/vagrant/oradata", owner: "oracle", group: "oinstall"



  # if Vagrant.has_plugin?("vagrant-proxyconf")
  #   config.proxy.http     = "http://proxy.example.com/"
  #   config.proxy.https    = "http://proxy.example.com/"
  #   config.proxy.no_proxy = "localhost,127.0.0.1"
  # end
end
