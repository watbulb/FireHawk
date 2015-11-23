#!/bin/bash
# ---------------------------------------------------------------------------
# firepick_install.sh - To Install FirePick System on a Raspberry Pi

# The MIT License (MIT)

# Copyright (c) 2015 Dayton Pidhirney <daytonpid@gmail.com>


# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:


# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.


# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Revision history:
# 2015-11-22 First revision. Logfile support.
# ---------------------------------------------------------------------------
PROGNAME=firepick_install
clean_up() { # Perform pre-exit housekeeping
  apt-get clean
  return
}

error_exit() { # Echo then turn on power LED to incicate faliure
  echo -e "${1:-"Unknown Error"}" >&2
  echo default-on | sudo tee /sys/class/leds/led1/trigger >/dev/null
  if [ -f ~/FireSight ]; then
     rm -rf ~/FireSight   
  fi

  if [ -f ~/firenodejs ]; then
     rm -rf ~/firenodejs   
  fi

  clean_up
  exit 1
}

graceful_exit() {
  clean_up
  exit
}

signal_exit() { # Handle trapped signals
  case $1 in
    TERM)
      echo -e "\n$PROGNAME: Program terminated" >&2
      graceful_exit ;;
    *)
      error_exit "$PROGNAME: Terminating on unknown signal" ;;
  esac
}

# Trap signals
trap "signal_exit TERM" TERM HUP

fail() { # Turn power LED on to indicate faliure
  echo "Oh noes, something went wrong!"
  echo default-on | sudo tee /sys/class/leds/led1/trigger >/dev/null
  exit
}

success() { # Turn act LED on to indicate successful installation
  echo "FirePick system install comlpete!"

  chmod -x /etc/init.d/firepick_install.sh || fail
  rm /etc/rc3.d/S99firepick_install || fail

  rpi-update || fail # update system kernel and firmware
  cp -v /boot/vmlinuz-* /boot/kernel.img || fail # copy configured vmlinuz image to the kernel

  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/sbin || fail #export proper path

  echo default-on | sudo tee /sys/class/leds/led0/trigger >/dev/null || fail
  sleep 60

  reboot
  exit
}

# Main logic

LOGFILE=/var/log/firepick_install.log

# redirect stdout and stderr also to logfile

mkfifo ${LOGFILE}.pipe
tee < ${LOGFILE}.pipe $LOGFILE &
exec &> ${LOGFILE}.pipe
rm ${LOGFILE}.pipe

# update and install packages

echo "Updating and upgrading package lists . . ."
sudo apt-get update || fail
sudo apt-get upgrade || fail

echo "installing dependencies and required packages . . ."
apt-get -y install raspi-copies-and-fills libraspberrypi-bin apt-utils rpi-update git build-essential libatlas-base-dev gfortran autoconf streamer || fail # install needed packages

# Install FireSight

echo "Installing FireSight and it's dependencies . . ."
git clone https://github.com/daytonpid/FireSight.git /home/fireuser/FireSight || fail
cd /home/fireuser/FireSight || fail
bash build || error_exit
cd ~ || fail
usermod -aG video fireuser || fail

echo "Install success!"

# Install Firenodejs

echo "Installing firenodejs and it's dependencies . . ."
git clone https://github.com/daytonpid/firenodejs.git /home/fireuser/firenodejs || fail
cd /home/fireuser/firenodejs || fail
bash /home/fireuser/firenodejs/scripts/install.sh || error_exit
cd ~ || fail


graceful_exit
success