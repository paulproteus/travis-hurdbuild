#!/bin/bash
set -e
set -x

# Download the thing
wget http://ftp.debian-ports.org/debian-cd/hurd-i386/current/debian-hurd.img.tar.gz

# Unpack it!
tar zxvf debian-hurd.img.tar.gz

# Make sure the sha1sum matches
sha1sum debian*img | grep f40a83f105f4fffd4074867c196d798feea43468

# get modules that we're missing, lulz
wget http://download.openvz.org/kernel/branches/rhel6-2.6.32/042stab090.5/linux-image-2.6.32-openvz-042stab090.5-amd64_1_amd64.deb
sudo dpkg -i --force-overwrite linux-image-2.6.32-openvz-042stab090.5-amd64_1_amd64.deb

# FIXME: Patch out the /etc/shadow
sudo apt-get install kpartx
sudo depmod -a
sudo modprobe dm-mod
sudo kpartx -a -v debian-hurd-20130504.img
sudo mount /dev/mapper/loop0p1 /mnt
echo 'root:$6$n.U8oNtR$/TJc3k951EJcCj.4D34k/lwiLobWlFVmpT91c19XYSWAk4KJtihZOYV0OqBR14FE4dvlmm5JUc7Tc2WWPzxT2.:16280:0:99999:7:::' > /tmp/new-shadow
sudo grep -v ^root /mnt/etc/shadow >> /tmp/new-shadow
sudo chmod --reference-file=/mnt/etc/shadow /tmp/shadow
sudo chown --reference-file=/mnt/etc/shadow /tmp/shadow
sudo mv /tmp/shadow /mnt/etc/shadow
sudo umount /mnt

exit 0

# install qemu
sudo apt-get install qemu

# run it, in the background
qemu -redir tcp:5556::22 debian-hurd*img -curses

# Wait for SSH to come online
ssh -p 5556 root@localhost echo hello from hurd

# SSH in

# rofl
