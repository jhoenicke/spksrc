PKG_NAME = transmission
PKG_VERS = 2.82
PKG_EXT = tar.xz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://download.transmissionbt.com/files
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = 

HOMEPAGE = http://www.transmissionbt.com/
COMMENT  = A Fast, Easy, and Free BitTorrent Client
LICENSE  =

GNU_CONFIGURE = 1
CONFIGURE_ARGS = HAVE_CXX=yes PKG_CONFIG_PATH=$(WORK_DIR)/../../../toolchains/$(TC)/work/usr/syno/lib/pkgconfig/ --disable-gtk --disable-nls --enable-daemon --enable-utp

include ../../mk/spksrc.cross-cc.mk
