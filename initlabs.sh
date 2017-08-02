#!/bin/bash
echo "-----------------------"                      
echo "This script will convert Devuan Jessie 1.0.0 LTS for amd64 into bunsenlabs 8.7" 
echo "(last stable at the time of release)."
echo "                                              "
echo "In theory it should work with any Debian distro (and the next Devuan versions"
echo "that integrate s6, runit or any  init system other than sysvinit), but it has only been tested"
echo "under a normal desktop usage with the sysvinit version (the only one currently available)."
echo "in order to ensure its perfect operation,             "
echo "please install Devuan without any desktop environment"
echo "(the option is under Graphical Expert Install)."
echo "                                   "
echo "Also, make sure you have a working Internet connection."
echo "This script will require super-user privileges in order to make the following changes:"
echo "It will add the bl repos, their respective gpg key, install the required packages,"
echo "Allow a user to reboot or shutdown the machine without super-user privileges,"
echo "And then fix the bl-exit application so it performs poweroff/reboot using working sysvinit commands."
echo "Please run as  this script as root."
echo "------------------------"
cp sources.list /etc/apt/sources.list
wget https://pkg.bunsenlabs.org/debian/pool/main/b/bunsen-keyring/bunsen-keyring_2016.7.2-1_all.deb
dpkg -i bunsen-keyring_2016.7.2-1_all.deb
apt-get update
apt -y install openbox pulseaudio xserver-xorg-video-ati xserver-xorg-video-radeon xserver-xorg-video-nvidia xserver-xorg-video-nouveau bunsen-meta-all
apt -y purge xfce4-notifyd
chmod 7777 /sbin/shutdown
cp bl-exit /usr/bin/bl-exit
echo "Done. Rebooting..."
shutdown -r now
