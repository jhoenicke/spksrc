PKG_NAME = minidlna
PKG_VERS = 1.1.2
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://downloads.sourceforge.net/project/minidlna/minidlna/$(PKG_VERS)
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = cross/libid3tag cross/libvorbis cross/libogg cross/flac

HOMEPAGE = http://minidlna.sourceforge.net/
COMMENT  = ReadyMedia (formerly miniDLNA) is a simple media server software, with the aim of being fully compliant with DLNA/UPnP-AV clients.
LICENSE  =

GNU_CONFIGURE = 1
CONFIGURE_ARGS = HAVE_CXX=yes INCLUDE_DIR="$(WORK_DIR)/../../../toolchains/$(TC)/work/usr/syno/include/ffmpeg"

include ../../mk/spksrc.cross-cc.mk
