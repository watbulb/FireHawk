#!/bin/bash
# The MIT License (MIT)

# Copyright (c) 2015 daytonpid@gmail.com

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1

set -e

echo "post-install - STAGE 0"
	apt-get -y install raspi-copies-and-fills raspi-config libraspberrypi-bin btrfs-tools apt-utils rpi-update git unzip
	

echo "post-install - STAGE 1"
	btrfs subvolume create /.snapshot
	btrfs subvolume snapshot -r / /.snapshot/base-system/

echo "post-install - STAGE 2"
	rpi-update
	cp -v /boot/vmlinuz-* /boot/kernel.img

echo "post-install - STAGE 3" ## create a btrfs volume on a usb stick and add it to the fstab
	#mkfs.btrfs /dev/sda
	#(
	#	echo
	#	echo '/dev/sda        /data/local     btrfs   defaults 0 0'
	#	echo
	#) >> /etc/fstab
	#mkdir -pv /data/local
	#mount -v  /data/local
	#btrfs subvolume create /data/local/.snapshot

echo "post-install - STAGE 4" ## **FINAL STEP FOR BETA TESTING**
	#btrfs subvolume snapshot -r / /.snapshot/configured-system

echo "post-install - DONE"
echo "	sleeping 5 seconds then flash ACT and power LED's to indicate installation completion ..."
	sleep 5
	export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin
	echo default-on | sudo tee /sys/class/leds/led1/trigger >/dev/null

# EOF
