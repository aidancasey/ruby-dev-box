# ruby-dev-box
A fully scripted ruby development environment in a fresh a virtual machine using vagrant & chef

## pre requisites
1. Install Virtual Box
2. Install Vagrant


3. Install vagrant-vbguest plugin

This  automatically installs the host's VirtualBox Guest Additions on the guest system.
```javascript
vagrant plugin install vagrant-vbguest
```


4. Install vagrant-librarian-chef plugin

vagrant-librarian-chef let's us automatically run chef when we fire up our machine.
```javascript
vagrant plugin install vagrant-librarian-chef-nochef
```


5. Install vagrant-reload plugin

vagrant-reload lets you reboot your VM during provisioning, this is needed as part of installing ubuntu-desktop...

```javascript
vagrant plugin install vagrant-reload
```

## to make yourself a  a fresh virtual machine
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
