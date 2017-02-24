# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'base-box/oraclelinux-7-x86_64.box'

  config.vm.box_check_update = false
  config.vbguest.auto_update = false

  config.ssh.insert_key = false
  config.ssh.password = 'vagrant'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 4096
    v.name = 'oracle12c-vagrant'
    v.cpus = 4
    v.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end

  config.vm.network 'forwarded_port', guest: 1521, host: 1521

  config.vm.provision 'shell', path: 'scripts/install.sh'

end
