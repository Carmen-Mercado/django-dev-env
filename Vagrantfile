# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "centos/6"

  # mount directories
  config.vm.synced_folder "salt/roots/", "/srv/salt/", type: "nfs"
  config.vm.synced_folder "../demo/", "/opt/projects/demo/", type: "nfs"

  config.vm.provider "vmware_fusion" do |v|
    v.gui = false
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # django server
  config.vm.network "forwarded_port", guest: 8000, host: 18000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.1.63"

  # vagrant instance hostname
  config.dns.tld = "proof.code"
  config.vm.hostname = "djangobox"
  config.dns.patterns = [/^.*.proof.code$/]

  # provision with salt
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minions/dave"
    salt.run_highstate = true
  end

  config.vm.provider :vmare_fusion do |vmware|
    vmware.vmx["ethernet1.pcislotnumber"] = "33"
  end

end
