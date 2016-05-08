#!/bin/sh
#
# firenodejs-start.sh init script

sudo -u firehawk mount -t tmpfs -o size=64m tmpfs /var/img

cd /home/firehawk/firenodejs

sudo -u firehawk /home/firehawk/firenodejs/scripts/startup.sh

exit 0
