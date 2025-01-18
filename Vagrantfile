# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "almalinux/9"
  config.vm.box_version = "9.5.20241203"

  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 4096
    libvirt.cpus = 4
    libvirt.cputopology :sockets => '1', :cores => '2', :threads => '2'
    libvirt.graphics_type = none
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
  end
end
