# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # copied directly from vagrant init chef/centos-6.5
  config.vm.box = "bento/centos-7.2"

  # auto-update guest additions so we can ssh into the box
  config.vbguest.auto_update = true

  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
  end

  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 1521, host: 1521

  # run setup.sh the first time
  config.vm.provision "shell", path: "install.sh"
  
  # start oracle and listener every time
  config.vm.provision "shell", path: "startup.sh", run: "always"

end
