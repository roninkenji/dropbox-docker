#!/bin/bash

DROPBOX_USER=${DROPBOX_USER:-nobody}
DROPBOX_USERID=${DROPBOX_USERID:-99}
DROPBOX_GROUP=${DROPBOX_GROUP:-users}
DROPBOX_GROUPID=${DROPBOX_GROUPID:-100}

getent group ${DROPBOX_GROUP} && groupadd -g ${DROPBOX_GROUPID} ${DROPBOX_GROUP}
getent passwd ${DROPBOX_USER} || useradd -d /dropbox --gid=${DROPBOX_GROUP} --groups=users --uid=${DROPBOX_USERID} ${DROPBOX_USER}
usermod -d /dropbox -m ${DROPBOX_USER}

[ ! -f $HOME/.dropbox-dist/dropboxd ] && cp -rp /usr/local/.dropbox-dist $HOME/.
[ ! -d $HOME/.dropbox/instance1 ] && exec $HOME/.dropbox-dist/dropboxd
su - ${DROPBOX_USER} -c "/usr/local/bin/dropbox.py start"

