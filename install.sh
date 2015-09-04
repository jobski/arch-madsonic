#!/bin/bash

# define pacman packages
pacman_packages="libcups jre7-openjdk-headless fontconfig unzip"

# install pre-reqs
pacman -Sy --noconfirm
pacman -S --needed $pacman_packages --noconfirm

# create destination directories
mkdir -p /opt/madsonic/media
mkdir -p /opt/madsonic/transcode

# download madsonic standalone
curl -o /opt/madsonic/madsonic.zip -L http://madsonic.org/download/5.1/20150506_madsonic-5.1.5240-standalone.zip

# download madsonic transcode
curl -o /opt/madsonic/transcode/transcode.zip -L http://www.madsonic.org/download/transcode/20141017_madsonic-transcode_latest_x64.zip

# unzip madsonic and transcode
unzip /opt/madsonic/madsonic.zip -d /opt/madsonic
unzip /opt/madsonic/transcode/transcode.zip -d /opt/madsonic/transcode

# remove source zip files
rm /opt/madsonic/madsonic.zip
rm /opt/madsonic/transcode/transcode.zip

# force process to run as foreground task
sed -i 's/-jar madsonic-booter.jar > \${LOG} 2>\&1 \&/-jar madsonic-booter.jar > \${LOG} 2>\&1/g' /opt/madsonic/madsonic.sh

# set permissions
chown -R nobody:users /opt/madsonic
chmod -R 775 /opt/madsonic

# cleanup
yes|pacman -Scc
rm -rf /usr/share/locale/*
rm -rf /usr/share/man/*
rm -rf /tmp/*
