SUMMARY = "Add firehawk_welcome.sh to .bashrc"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://firehawk_welcome.sh"

PR = "0"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 firehawk_welcome.sh ${D}${bindir}
}

FILES_${PN} = "${bindir}"