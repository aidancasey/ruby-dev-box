#!/bin/sh

sudo apt-get install default-jdk


sudo mkdir -p -m a=rwx "$HOME/devtools"
wget http://download.jetbrains.com/ruby/RubyMine-7.1.4.tar.gz -O  /home/vagrant/devtools/RubyMine-7.1.4.tar.gz 
sudo tar -xzvf /home/vagrant/devtools/RubyMine-7.1.4.tar.gz  -C /home/vagrant/devtools
/home/vagrant/devtools/RubyMine-7.1.4/bin/rubymine.sh