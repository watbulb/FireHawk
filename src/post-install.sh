# post-install.txt

if [ "$1" == "install" ]
then

	set -e

	echo "post-install - STAGE 0"
		dpkg-reconfigure locales
		dpkg-reconfigure tzdata

	echo "post-install - STAGE 1"
		apt-get -y install raspi-copies-and-fills raspi-config libraspberrypi-bin btrfs-tools apt-utils rpi-update
		btrfs subvolume create /.snapshot
		btrfs subvolume snapshot -r / /.snapshot/base-system/

	echo "post-install - STAGE 2"
		rpi-update
		cp -v /boot/vmlinuz-* /boot/kernel.img

	echo "post-install - STAGE 4"
		apt-get -y install git unzip

	echo "post-install - STAGE 6"
		mkfs.btrfs /dev/sda
		(
			echo
			echo '/dev/sda        /data/local     btrfs   defaults 0 0'
			echo
		) >> /etc/fstab
		mkdir -pv /data/local
		mount -v  /data/local
		btrfs subvolume create /data/local/.snapshot

	echo "post-install - STAGE 7"
		btrfs subvolume snapshot -r / /.snapshot/configured-system

	echo "post-install - DONE"
	echo "	sleeping 30 seconds ..."
		sleep 30
		shutdown -r now

fi

# EOF
