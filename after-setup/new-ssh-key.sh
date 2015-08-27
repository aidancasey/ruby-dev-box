#!/bin/sh

ssh-keygen -t rsa -b 4096 -C "aidan.casey@myob.com"
# Creates a new ssh key, using the provided email as a label
# Generating public/private rsa key pair.

ssh-add ~/.ssh/id_rsa

sudo apt-get install xclip
# Downloads and installs xclip. If you don't have `apt-get`, you might need to use another installer (like `yum`)

xclip -sel clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard
