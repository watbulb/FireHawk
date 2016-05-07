FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

LIC_FILES_CHKSUM = "file://LICENCE;md5=0448d6488ef8cc380632b1569ee6d196"

PR = "r13"

SRCREV = "17c28b9d1d234893b73adeb95efc4959b617fc85"

SRC_URI = "\
    git://github.com/${SRCFORK}/userland.git;protocol=git;branch=${SRCBRANCH} \
    file://0002-set-VMCS_INSTALL_PREFIX-to-usr.patch \
    "
