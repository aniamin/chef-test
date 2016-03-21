# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "nowshad"
  config.vm.box = "opscode-ubuntu-14.04"
  config.omnibus.chef_version = :latest
  config.vm.boot_timeout = 120
  config.berkshelf.enabled = true
  
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      }
    }
    chef.run_list = [
      "recipe[myapp::default]"
    ]
  end
end

  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
