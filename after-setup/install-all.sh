#!/bin/sh

echo "installing dev tools"

sudo mkdir -p -m a=rwx "$HOME/apps"


sudo ./install-sublime.sh

sudo ./install-rubymine.sh
