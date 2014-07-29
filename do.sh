#!/bin/bash
set -e
set -x

wget http://ftp.debian-ports.org/debian-cd/hurd-i386/current/debian-hurd.img.tar.gz
tar zxvf debian-hurd.img.tar.gz
sha1sum debian*img
