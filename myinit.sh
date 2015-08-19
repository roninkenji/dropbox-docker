#!/bin/bash

[ ! -f $HOME/.dropbox-dist/dropboxd ] && cp -rp /usr/local/.dropbox-dist $HOME/.
[ ! -d $HOME/.dropbox/instance1 ] && exec $HOME/.dropbox-dist/dropboxd
/usr/local/bin/dropbox.py start

