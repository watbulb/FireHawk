PR="0"

SRC_URI="http://downloads.sourceforge.net/project/zbar/zbar/0.10/zbar-0.10.tar.bz2"

SRC_URI[md5sum] = "0fd61eb590ac1bab62a77913c8b086a5"
SRC_URI[sha256sum] = "234efb39dbbe5cef4189cc76f37afbe3cfcfb45ae52493bfe8e191318bdbadc6"

LICENSE="LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE;md5=243b725d71bb5df4a1e5920b344b86ad"

S = "${WORKDIR}/zbar-0.10"

do_configure() {
  export CFLAGS=""
  ${S}/configure  --prefix=${D}/usr --host=${TARGET_SYS} --build=${BUILD_SYS}  --disable-video --without-imagemagick --without-gtk --without-python --without-qt --without-x --without-xshm --without-xv --without-jpeg
}

do_install() {
  make install
}

FILES_${PN}-dev = "/usr/include  /usr/lib/pkgconfig /usr/lib/libzbar.so"
FILES_${PN}-doc = "/usr/share"
FILES_${PN} += "/usr/bin /usr/lib/libzbar*"
