#!/bin/sh



sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
sudo apt-get install oracle-java7-set-default


wget http://download.jetbrains.com/ruby/RubyMine-7.1.4.tar.gz -O  /home/vagrant/apps/RubyMine-7.1.4.tar.gz 
sudo tar -xzvf /home/vagrant/apps/RubyMine-7.1.4.tar.gz  -C /home/vagrant/apps


sudo chown -R root:root /home/vagrant/devtools/RubyMine-7.1.4

cd /home/vagrant/devtools/RubyMine-7.1.4/bin/


sudo ./rubymine.sh
