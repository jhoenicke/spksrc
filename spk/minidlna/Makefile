SPK_NAME = minidlna
SPK_VERS = 1.1.2
SPK_REV = 2
SPK_ICON = src/minidlna.png
DSM_UI_DIR = app

DEPENDS = cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = "ReadyMedia (formerly known as miniDLNA) is a simple media server software, with the aim of being fully compliant with the aim of being fully compliant with DLNA/UPnP-AV clients."
DISPLAY_NAME = ReadyMedia
CHANGELOG = ""

HOMEPAGE = http://minidlna.sourceforge.net/
LICENSE  =

#WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = minidlna_extra_install

include ../../mk/spksrc.spk.mk

.PHONY: minidlna_extra_install
minidlna_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/var/run
	install -m 755 -d $(STAGING_DIR)/var/cache
	install -m 755 -d $(STAGING_DIR)/var/log
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 644 src/etc/minidlna.conf $(STAGING_DIR)/etc/minidlna.conf.in
