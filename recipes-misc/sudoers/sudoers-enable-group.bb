# Edit sudoers to allow the use of the wheel group and non root users to mount/shutdown etc.
# Please consider this when using.

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

PR = "r0"

DEPENDS = "sudo"

ALLOW_EMPTY_${PN} = "1"

pkg_postinst_${PN} () {
#!/bin/sh
sed -i /# %wheel/d $D${sysconfdir}/sudoers
echo '%wheel	ALL=(ALL) ALL' >> $D${sysconfdir}/sudoers
sed -i /# %users/d $D${sysconfdir}/sudoers
echo '%users  ALL=/sbin/mount /cdrom,/sbin/umount /cdrom' >> $D${sysconfdir}/sudoers
echo '%users  localhost=/sbin/shutdown -h now' >> $D${sysconfdir}/sudoers
}
