SUMMARY = "Current FireHawk development package"
HOMEPAGE = "https://github.com/daytonpid/FireHawk"
LICENSE = "MIT"
IMAGE_LINGUAS = "en-us"

inherit core-image
inherit extrausers

DEPENDS += "bcm2835-bootfiles"

CORE_OS = " \
    openssh openssh-keygen openssh-sftp-server \
    tzdata \
    resize-rootfs \
    sudo \
    sudoers-enable-group \
 "

WIFI_SUPPORT = " \
    iw \
    linux-firmware-brcm43430 \
    linux-firmware-ralink \
    linux-firmware-rtl8192ce \
    linux-firmware-rtl8192cu \
    linux-firmware-rtl8192su \
    wireless-tools \
    wpa-supplicant \
 "

DEV_SDK_INSTALL = " \
    binutils \
    binutils-symlinks \
    gcc \
    gcc-symlinks \
    g++ \
    g++-symlinks \
    libstdc++ \
    libstdc++-dev \
    git \
    libtool \
    make \
    cmake \
    automake \
    autoconf \
    pkgconfig \
 "

DEV_EXTRAS = " \
    ntp \
    ntp-tickadj \
    nbench-byte \
 "

EXTRA_TOOLS_INSTALL = " \
    bc \
    bzip2 \
    ZBar \
    e2fsprogs-resize2fs \
    i2c-tools \
    less \
    nano \
    unzip \
    htop \
    parted \
    util-linux \
    wget \
    packagegroup-core-boot \
    firenodejs-start \
 "

RPI_STUFF = " \
    bcm2835-tests \
    userland \
    firehawk-welcome \
 "

IMAGE_INSTALL += " \
    ${CORE_OS} \
    ${DEV_SDK_INSTALL} \
    ${DEV_EXTRAS} \
    ${EXTRA_TOOLS_INSTALL} \
    ${RPI_STUFF} \
    ${WIFI_SUPPORT} \
 "

disable_bootlogd() {
    echo BOOTLOGD_ENABLE=no > ${IMAGE_ROOTFS}/etc/default/bootlogd
}

EXTRA_USERS_PARAMS = " \
        useradd -P firepick firehawk; \
        groupadd sudo ; \
        groupadd wheel; \
        usermod -a -G wheel,video,sudo firehawk; \
        usermod -L root; \
  "

ROOTFS_POSTPROCESS_COMMAND += " \
    disable_bootlogd ; \
 "

export IMAGE_BASENAME = "firehawk-image"
