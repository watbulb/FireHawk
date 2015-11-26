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
  if [ -f /home/fireuser/FireSight ]; then
     echo "removing FireSight"
     rm -rf /home/fireuser/FireSight
  fi

  if [ -f /home/fireuser/firenodejs ]; then
     echo "removing firenodejs"
     rm -rf /home/fireuser/firenodejs
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
  echo default-on | sudo tee /sys/class/leds/led1/trigger >/dev/null 

}

# Trap signals
trap "signal_exit TERM" TERM HUP

fail() { # Turn power LED on to indicate faliure
  echo default-on | sudo tee /sys/class/leds/led1/trigger >/dev/null
  echo "Oh noes, something went wrong! Copying log file to /boot . . ."
  cp /var/log/firepick_install.log /boot || echo "There was an error copying the logfile to /boot!" # Copy firepick log to boot partition for further inspection

  exit
}

success() { # Final steps then reboot
  echo "FirePick system install comlpete!"
  chmod -x /etc/init.d/firepick_install.sh || fail

  rpi-update || fail # update system kernel and firmware
  cp -v /boot/vmlinuz-* /boot/kernel.img || fail # copy configured vmlinuz image to the kernel

  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin || fail # export proper path

  mv /boot/config-post.txt /boot/config.txt || fail # move config-post.txt to default config.txt

  apt-get clean || fail # clean the apt cache

  dd if=/dev/zero of=/swap bs=1M count=512 && mkswap /swap || fail # Create swap file

  echo "/swap none swap sw 0 0" >> /etc/fstab  || fail # Appending swap info to fstab

  su - fireuser -s/bin/bash -c node /home/fireuser/firenodejs/js/server.js

  modprobe ledtrig_heartbeat
  echo heartbeat | sudo tee /sys/class/leds/led1/trigger >/dev/null # }
  sleep 0.05                                                        # --- Pulse strobe LED's to indicate success
  echo heartbeat | sudo tee /sys/class/leds/led0/trigger >/dev/null # }
  exit
}

# Main logic

LOGFILE=/var/log/firepick_install.log

# redirect stdout and stderr to logfile

mkfifo ${LOGFILE}.pipe
tee < ${LOGFILE}.pipe $LOGFILE &
exec &> ${LOGFILE}.pipe
rm ${LOGFILE}.pipe

# update and install packages

echo "Updating and upgrading package lists . . ."
sudo apt-get update || fail
sudo apt-get upgrade || fail

echo "installing dependencies and required packages . . ."
apt-get -y install raspi-copies-and-fills apt-utils rpi-update git pkg-config autoconf streamer unzip || fail # install needed packages

# Install FireSight

echo "Installing FireSight and it's dependencies . . ."
git clone https://github.com/daytonpid/FireSight.git /home/fireuser/FireSight || fail
cd /home/fireuser/FireSight || fail
bash build || error_exit
cd ~ || fail
usermod -aG video fireuser || fail

# Install Firenodejs

echo "Installing firenodejs and it's dependencies . . ."
git clone https://github.com/daytonpid/firenodejs.git /home/fireuser/firenodejs || fail
cd /home/fireuser/firenodejs || fail
bash /home/fireuser/firenodejs/scripts/install.sh || error_exit
cd ~ || fail

success
