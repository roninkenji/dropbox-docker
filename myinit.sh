#!/bin/bash

DROPBOX_USER=${DROPBOX_USER:-nobody}
DROPBOX_USERID=${DROPBOX_USERID:-99}
DROPBOX_GROUP=${DROPBOX_GROUP:-users}
DROPBOX_GROUPID=${DROPBOX_GROUPID:-100}

getent group ${DROPBOX_GROUP} 2>&1 > /dev/null || groupadd -g ${DROPBOX_GROUPID} ${DROPBOX_GROUP}
getent passwd ${DROPBOX_USER} 2>&1 > /dev/null && usermod -d /dropbox -s /bin/bash ${DROPBOX_USER}
getent passwd ${DROPBOX_USER} 2>&1 > /dev/null || useradd -d /dropbox -g ${DROPBOX_GROUP} -G users -u ${DROPBOX_USERID} -s /bin/bash ${DROPBOX_USER}

[ ! -f /dropbox/.dropbox-dist/dropboxd ] && su -l ${DROPBOX_USER} -c "cp -r /usr/local/.dropbox-dist /dropbox/."
su -l ${DROPBOX_USER} -c "/dropbox/.dropbox-dist/dropboxd"

