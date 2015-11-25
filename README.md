# firehawk-ua-netinst

<a><img src="http://cdn.warcraftpets.com/images/pets/big/blazing-firehawk.v9373.jpg" align="left" hspace="10" vspace="6></a>

The minimal unattended FirePick netinstaller for Raspberry Pi Model 1B, 1B+ and 2B.  


This project provides FirePick users the possibility to install a minimal base Raspbian system unattended using latest Raspbian and FirePick packages regardless when the installer was built.

The installer with default settings configures eth0 with DHCP to get Internet connectivity and completely wipes the SD card from any previous installation.

There are different kinds of "presets" that define the default packages that are going to be installed. Currently, the default one is called _server_ which installs only the essential base system packages including _NTP_ and _OpenSSH_ to provide a sane minimal base system that you can immediately after install ssh in and continue installing your software.

Other presets include _minimal_ which has even less packages (no logging, no text editor, no cron) and _base_ which doesn't even have networking. You can customize the installed packages by adding a small configuration file to your SD card before booting up.
