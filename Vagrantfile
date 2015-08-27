# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Use Ubuntu  A standard Ubuntu 12.04 LTS 32-bit as our operating system
  config.vm.box = "hashicorp/precise32"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  #config.vm.synced_folder ".", "/vagrant", type: "smb"


 config.vbguest.auto_update = false

  # do NOT download the iso file from a webserver
  config.vbguest.no_remote = true


  # Configurate the virtual machine to use 4GB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
    vb.gui = true
  end

  # Forward the Rails server default port to the host
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # Use Chef Solo to provision our virtual machine
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]

    chef.add_recipe "apt"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rbenv::user"
    chef.add_recipe "rbenv::vagrant"
    chef.add_recipe "vim"
    chef.add_recipe "java"
    chef.add_recipe "ruby_rvm"



    # Install Ruby 2.2.1 and Bundler
    # Set an empty root password for MySQL to make things simple
    chef.json = {
      rbenv: {
        user_installs: [{
          user: 'vagrant',
          rubies: ["2.2.1"],
          global: "2.2.1",
          gems: {
            "2.2.1" => [
              { name: "bundler" }
            ]
          }
        }]
      },
      mysql: {
        server_root_password: ''
      }
    }
  end


#  install desktop GUI

 config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y ubuntu-desktop
 #    sudo apt-get install -y kde-full
    sudo apt-get install -y virtualbox-guest-dkms 
   sudo apt-get install -y virtualbox-guest-utils virtualbox-guest-x11
  SHELL

#reboot VM adfter desktop gui is installed
 config.vm.provision :reload

end