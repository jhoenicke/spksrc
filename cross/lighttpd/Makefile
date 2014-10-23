PKG_NAME = lighttpd
PKG_VERS = 1.4.35
PKG_EXT = tar.gz
PKG_DIST_NAME = $(PKG_NAME)-$(PKG_VERS).$(PKG_EXT)
PKG_DIST_SITE = http://download.lighttpd.net/lighttpd/releases-1.4.x
PKG_DIR = $(PKG_NAME)-$(PKG_VERS)

DEPENDS = 

HOMEPAGE = http://www.lighttpd.net/
COMMENT  = ReadyMedia (formerly miniDLNA) is a simple media server software, with the aim of being fully compliant with DLNA/UPnP-AV clients.
LICENSE  =

GNU_CONFIGURE = 1
CONFIGURE_ARGS = --prefix=/opt --with-openssl HAVE_CXX=yes PCRECONFIG=$(TC_PATH)/../../usr/syno/bin/pcre-config


include ../../mk/spksrc.cross-cc.mk
