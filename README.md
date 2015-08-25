# ruby-dev-box

A fully scripted ruby development environment in a fresh a virtual machine using vagrant & chef

## pre requisites
1. Install Virtual Box  (https://www.virtualbox.org/wiki/Downloads)

2. Install Vagrant (http://www.vagrantup.com/downloads.html)


3. Install Some Useful Vagrant plugins

vagrant-vbguest plugin -it automatically installs the host's VirtualBox Guest Additions on the guest system.
vagrant-librarian-chef -  let's you automatically run chef when we fire up your machine.
vagrant-reload - let's you reboot your VM during provisioning, (this is needed as part of installing ubuntu-desktop...)

```javascript

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-librarian-chef-nochef
vagrant plugin install vagrant-reload

```
## Now, to make yourself a  fresh virtual machine
- to create a fresh machine and ssh into it :
```javascript
vagrant up

```
The first time you run vagrant it  will take a while because it will provision your virtual machine with the chef configuration & install ubuntu-desktop. After the first time, vagrant up won't have to run Chef and it will boot much faster.
You can now log into the machine 

username : vagrant

password : vagrant

## to reconfiguring a machine
If you ever edit your Vagrantfile or Cheffile, you can use the following command to reconfigure the machine.

```javascript
vagrant provision
```

# to do list
(1) Automatically add RubyMine to the fresh VM
