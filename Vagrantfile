# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.box = "geerlingguy/centos7"


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8001
  config.vm.network "forwarded_port", guest: 3306, host: 3307


  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"


  ## mount root folder
  #config.vm.synced_folder "./", "/srv/www/awsalt", id: "vagrant-root",
  #     owner: "vagrant",
  #     group: "www-data",
  #     mount_options: ["dmode=775,fmode=664"]


  ## For masterless, mount your salt file root
  config.vm.synced_folder "salt", "/srv/salt/"

  ## Set your salt configs here
  config.vm.provision :salt do |salt|

    ## Minion config is set to "file_client: local" for masterless
    #salt.verbose = true
    salt.minion_config = "salt/minion"
    salt.run_highstate = true

  end

end
