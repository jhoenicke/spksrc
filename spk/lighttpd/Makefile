SPK_NAME = lighttpd
SPK_VERS = 1.4.35
SPK_REV = 1
SPK_ICON = src/lighttpd.png
DSM_UI_DIR = app

DEPENDS = cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = "ReadyMedia (formerly known as miniDLNA) is a simple media server software, with the aim of being fully compliant with the aim of being fully compliant with DLNA/UPnP-AV clients."
DISPLAY_NAME = ReadyMedia
CHANGELOG = ""

HOMEPAGE = http://www.lighttpd.net/
LICENSE  =

#WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /opt

POST_STRIP_TARGET = lighttpd_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: lighttpd_extra_install
lighttpd_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/var/run
	install -m 755 -d $(STAGING_DIR)/var/cache
	install -m 755 -d $(STAGING_DIR)/var/log
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 644 src/etc/lighttpd.conf $(STAGING_DIR)/etc/lighttpd.conf.in
