# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # copied directly from vagrant init chef/centos-6.5
  config.vm.box = "bento/centos-7.2"
  
  config.vm.box_check_update = false
  config.vbguest.auto_update = true
  
  # workaround the vagrant 1.8.5 bug
  config.ssh.insert_key = false

  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 4000
    v.name = "oracle12c-vagrant"
  end

  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 1521, host: 1521

  # Provision everything on the first run
  config.vm.provision "shell", path: "scripts/install.sh"

  # if Vagrant.has_plugin?("vagrant-proxyconf")
  #   config.proxy.http     = "http://proxy.example.com/"
  #   config.proxy.https    = "http://proxy.example.com/"
  #   config.proxy.no_proxy = "localhost,127.0.0.1"
  # end
end
