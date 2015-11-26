# `WORK IN PROGRESS`

This installer with default settings configures eth0 (`ethernet port`) with DHCP to get Internet connectivity and completely wipes the SD card from any previous installation. It will bootstrap a minimal Raspbian. Once completed the following FirePick packages will be installed and a system update of firmware and kernel will be performed.

- `FireSight`
- `firenodejs`&trade;
- `FireStep`

## Features
 - Completely unattended, you only need working Internet connection through the Ethernet port
 - DHCP and static IP configuration (DHCP is the default)
 - Always installs the latest version of Raspbian and FirePick packages
 - Configurable default settings
 - Extra configuration over HTTP possible - gives unlimited flexibility
 - Installation takes about **45 minutes** with fast Internet from power on to nodejs server running
 - Boots in less than 15 seconds
 - Can fit on a 2GB SD card
 - Install includes fake-hwclock to save time on shutdown and bootup
 - Install includes NTP to keep time
 - Many locations including /tmp are mounted as tmpfs to improve speed
 - No clutter and bloatware included, you only get the bare essential packages
 - Option to install root to USB drive instead of a SD Card
 - 512MB swap file

### To be added
 - NEON + VFP4 Optimized OpenCV


## Requirements
 - A Raspberry Pi Model 1B, Model 1B+ or Model 2B
 - SD card of at least 2GB or at least 750MB for USB root install
 - Working Ethernet with Internet connectivity
 - A Raspberry Pi CSI Camera
 - `Optional:` FireStep motion control board needed to interface machine with steppers

 _**Note:** The Raspberry Pi CSI Camera is needed for firenodejs to run properly. It is recommended that you install it on your Pi before starting the install process._

## Writing the installer to the SD card
### Obtaining installer files on Windows and Mac
Installer archive is around **17MB** and contains all firmware files and the installer.

Go to [our latest release page](https://github.com/debian-pi/raspbian-ua-netinst/releases/latest) and download the .zip file.

Format your SD card as **FAT32** (MS-DOS on _Mac OS X_) and extract the installer files in.

_**Note:** If you get an error saying it can't mount /dev/mmcblk0p1 on /boot then the most likely cause is that you're using exFAT instead of FAT32._

Try formatting the SD card with this tool: https://www.sdcard.org/downloads/formatter_4/

### Alternative method for Mac, writing image to SD card
Prebuilt image is around **17MB** bzip2 compressed and **64MB** uncompressed. It contains the same files as the .zip but is more convenient for Mac users.

Go to [our latest release page](https://github.com/debian-pi/raspbian-ua-netinst/releases/latest) and download the .img.bz2 file.

Extract the .img file from the archive with `bunzip2 raspbian-ua-netinst-<latest-version-number>.img.bz2`.  
Find the _/dev/diskX_ device you want to write to using `diskutil list`. It will probably be 1 or 2.  

To flash your SD card on Mac:

    diskutil unmountDisk /dev/diskX
    sudo dd bs=1m if=/path/to/firehawk-ua-netinst-<latest-version-date>.img of=/dev/rdiskX
    diskutil eject /dev/diskX

_**Note:** the **r** in the of=/dev/rdiskX part on the dd line which should speed up writing the image considerably._

### SD card image for Linux
Prebuilt image is around **11MB** xz compressed and **64MB** uncompressed. It contains the same files as the .zip but is more convenient for Linux users.

Go to [our latest release page](https://github.com/debian-pi/raspbian-ua-netinst/releases/latest) and download the .img.xz file.

To flash your SD card on Linux:

    xzcat /path/to/firehawk-ua-netinst-<latest-version-date>.img.xz > /dev/sdX

Replace _/dev/sdX_ with the real path to your SD card.

## Installing
In normal circumstances, you can just power on your Pi and cross your fingers. For indication purposes, your Pi will indicate the install has either succeeded or failed by controlling the on board PWR and ACT LED's. When the entire install process has finished successfully both the PWR and ACT LED's will flash in a strobe pattern. If an error has occurred, the PWR LED will stay solid. Once the install has been completed successfully you should be able to access the nodejs web server on your favorite browser by clicking this link [firepick:8080](firepick:8080) . If you think a error has occurred, please continue to [Troubleshooting](https://github.com/daytonpid/FireHawk/wiki#troubleshooting) below.

_If your Pi has indicated install completion and you can't access the nodejs serve, this could be why:_

Your Pi is not using your router as the default DNS, resulting in your computer not being able to recognize the hostname of the Pi. Please try using `your-pi's-ip:8080`.

## After Install

The default username is **fireuser** and the password is **firehawk**.

> Set new password: `passwd`  (can also be set during installation using **userpw** in [installer-config.txt](#installer-customization)

> Configure your default locale if needed: `dpkg-reconfigure locales`  
> Configure your timezone: `dpkg-reconfigure tzdata`  

The latest kernel and firmware packages are now automatically installed during the unattended installation process. If you need a kernel module that isn't loaded by default, you will still have to configure that manually in either the installed system or installer-config.

## Installer customization
You can use the installer _as is_ and get a minimal system installed which you can then use and customize to your needs.  
But you can also customize the installation process and the primary way to do that is through a file named _installer&#8209;config.txt_. When you've written the installer to a SD card, you'll see a file named _cmdline.txt_ and you create the _installer&#8209;config.txt_ file alongside that file.
The defaults for _installer&#8209;config.txt_ are displayed below. If you want one of those settings changed for your installation, you should **only** place that changed setting in the _installer&#8209;config.txt_ file. So if you want to have vim and aptitude installed by default, create a _installer&#8209;config.txt_ file with the following contents:
```
packages=vim,aptitude
```
and that's it! While most settings stand on their own, some settings influence each other. For example `rootfstype` is tightly linked to the other settings that start with `rootfs_`.  
So don't copy and paste the defaults from below!

The _installer&#8209;config.txt_ is read in at the beginning of the installation process, shortly followed by the file pointed to with `online_config`, if specified.
There is also another configuration file you can provide, _post&#8209;install.txt_, and you place that in the same directory as _installer&#8209;config.txt_.
The _post&#8209;install.txt_ is executed at the very end of the installation process and you can use it to tweak and finalize your automatic installation.  
The configuration files are read in as  shell scripts, so you can abuse that fact if you so want to. 

The format of the _installer&#8209;config.txt_ file and the current defaults:

    preset=server
    packages= # comma separated list of extra packages
    mirror=http://mirrordirector.raspbian.org/raspbian/
    release=jessie
    hostname=pi
    boot_volume_label= # Sets the volume name of the boot partition. The volume name can be up to 11 characters long. The label is used by most OSes (Windows, Mac OSX and Linux) to identify the SD-card on the desktop and can be useful when using multiple SD-cards.
    domainname=
    rootpw=raspbian
    root_ssh_pubkey= # public SSH key for root; on Debian "jessie" the SSH password login will be disabled for root if set; the public SSH key must be on a single line, enclosed in quotes
    disable_root= # set to 1 to disable root login (and password) altogether
    username= # username of the user to create
    userpw= # password to use for created user
    user_ssh_pubkey= # public SSH key for created user; the public SSH key must be on a single line, enclosed in quotes
    user_is_admin= # set to 1 to install sudo and make the user a sudo user
    cdebootstrap_cmdline=
    bootsize=+128M # /boot partition size in megabytes, provide it in the form '+<number>M' (without quotes)
    rootsize=     # / partition size in megabytes, provide it in the form '+<number>M' (without quotes), leave empty to use all free space
    timeserver=time.nist.gov
    timezone=Etc/UTC # set to desired timezone (e.g. Europe/Ljubljana)
    locales=  # a space delimited list of locales that will be generated during install (e.g. "en_US.UTF-8 nl_NL sl_SI.UTF-8")
    system_default_locale= # the default system locale to set (using the LANG environment variable)
    ifname=eth0
    ip_addr=dhcp
    ip_netmask=0.0.0.0
    ip_broadcast=0.0.0.0
    ip_gateway=0.0.0.0
    ip_nameservers=
    drivers_to_load=
    online_config= # URL to extra config that will be executed after installer-config.txt
    usbroot= # set to 1 to install to first USB disk
    cmdline="dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty1 elevator=deadline"
    rootfstype=ext4
    rootfs_mkfs_options=
    rootfs_install_mount_options='noatime,data=writeback,nobarrier,noinit_itable'
    rootfs_mount_options='errors=remount-ro,noatime'

The time server is only used during installation and is for _rdate_ which doesn't support the NTP protocol.  

Available presets: _server_, _minimal_ and _base_.
Presets set the `cdebootstrap_cmdline` variable. For example, the current _server_ default is:

> _--flavour=minimal --include=kmod,fake-hwclock,ifupdown,net-tools,isc-dhcp-client,ntp,openssh-server,vim-tiny,iputils-ping,wget,ca-certificates,rsyslog,dialog,locales,less,man-db_

(If you build your own installer, which most won't need to, and the configuration files exist in the same directory as this `README.md`, it will be include in the installer image automatically.)

## Logging
The output of the installation process is now also logged to file.  
When the installation completes successfully, the logfile is moved to /var/log/raspbian-ua-netinst.log on the installed system.  
When an error occurs during install, the logfile is moved to the sd card, which gets normally mounted on /boot/ and will be named raspbian-ua-netinst-\<datetimestamp\>.log

## Reinstalling or replacing an existing system
If there was an error in your last install or if you want to reinstall with the same or edited settings, you can just move the original _config.txt_ back and reboot. Make sure you still have _kernel_install.img_ and _installer.cpio.gz_ in your _/boot_ partition. If you are replacing your existing system which was not installed using this method, make sure you copy those two files in and the installer _config.txt_ from the original image.

    mv /boot/config-reinstall.txt /boot/config.txt
    reboot

**Remember to backup all your data and original config.txt before doing this!**

## Troubleshooting

**FireHawk is still in Beta, so bugs are to be expected.**

If you would like to view the bootstrapping process in order to diagnose any issues that may have arisen in the raspbian install process you can either simply hookup the Pi to a display or if you have a serial cable, open the img file by mounting it either by double clicking it for **Mac**, or running `mkdir /mnt/firehawk` followed by `mount -t fstype -o loop firehawk.img /mnt/firehawk` on **Linux**. Then remove 'console=tty1' at then end of the `cmdline.txt` file. Don't forget to eject it once you have finished editing, either by dragging the image to the trash for **Mac** or by running `umount /mnt/firehawk` followed by `rm -r /mnt/firehawk` on **Linux**.


### Fix if system failed FirePick install:

- If the system has been successfully bootstrapped and you see a solid red LED on your Pi, this means there was a faliure during the FirePick installation. You can view the log file on **Windows** by using ssh to log into the Pi with `ssh fireuser@ip` and navigate to `/var/log/`, you should see a `firepick_install.log` and can read it with either `cat` or `editor`. If you are on **Linux** / **Mac** you can download the log file to your computer by running `scp fireuser@ip:/var/log/firepick_install.log /savepoint`

### Fix if system failed bootstrap: 

- In the extremely rare case that the bootstrap has failed you have some options. The easiest method would be to remove the SD card from the Pi and insert it into a card reader on a separate machine. Access the card and view the error log `raspbian-ua-netinst-\<datetimestamp\>.log` in the root directory.
 

## Disclaimer
We take no responsibility for ANY data loss. You will be reflashing your SD card anyway so it should be very clear to you what you are doing and will lose all your data on the card. Same goes for reinstallation.

See LICENSE for license information.

  [1]: http://www.raspbian.org/ "Raspbian"
