#!/bin/bash
set -e
set -x

# Download the thing
wget http://ftp.debian-ports.org/debian-cd/hurd-i386/current/debian-hurd.img.tar.gz

# Unpack it!
tar zxvf debian-hurd.img.tar.gz

# Make sure the sha1sum matches
sha1sum debian*img | grep f40a83f105f4fffd4074867c196d798feea43468

# FIXME: Patch out the /etc/shadow
sudo apt-get install kpartx
sudo kpartx -a -v debian-hurd-20130504.img
sudo mount /dev/mapper/loop0p1 /mnt
echo 'root:$6$n.U8oNtR$/TJc3k951EJcCj.4D34k/lwiLobWlFVmpT91c19XYSWAk4KJtihZOYV0OqBR14FE4dvlmm5JUc7Tc2WWPzxT2.:16280:0:99999:7:::' > /tmp/new-shadow
sudo grep -v ^root /mnt/etc/shadow >> /tmp/new-shadow
sudo chmod --reference-file=/mnt/etc/shadow /tmp/shadow
sudo chown --reference-file=/mnt/etc/shadow /tmp/shadow
sudo mv /tmp/shadow /mnt/etc/shadow
sudo umount /mnt

# install qemu

# run it, in the background

# SSH in

# rofl
