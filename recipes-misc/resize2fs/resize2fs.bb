SUMMARY = "Build and install resize2fs from e2fsprogs"
LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
SRCREV = "d530271fb39cbf7fddf9fea55b4e4cf74142a98b"
SRC_URI = "git://github.com/tytso/e2fsprogs.git"
PR = "0"

S = "${WORKDIR}/git"

inherit autotools
