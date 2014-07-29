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

# install qemu

# run it, in the background

# SSH in

# rofl
