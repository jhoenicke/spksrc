#!/bin/sh

# Package
PACKAGE="minidlna"
DNAME="miniDLNA"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
PATH="${INSTALL_DIR}/bin:${PATH}"
USER="minidlna"
GROUP="users"
CFG_FILE="${INSTALL_DIR}/etc/minidlna.conf"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}
    mkdir -p ${SYNOPKG_PKGDEST}/var
    mkdir -p ${SYNOPKG_PKGDEST}/var/log
    mkdir -p ${SYNOPKG_PKGDEST}/var/cache
    mkdir -p ${SYNOPKG_PKGDEST}/var/pid

    # Create user
    synouser --add ${USER} `openssl rand 27 -base64 2>/dev/null` "${DNAME} User" 1 "" 0

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
	cat ${CFG_FILE}.in > ${CFG_FILE}

        # Edit the configuration according to the wizard
#        sed -i -e "s|@download_dir@|${wizard_download_dir:=/volume1/downloads}|g" ${CFG_FILE}
#        sed -i -e "s|@username@|${wizard_username:=admin}|g" ${CFG_FILE}
#        sed -i -e "s|@password@|${wizard_password:=admin}|g" ${CFG_FILE}
	HOSTNAME=`hostname`
	echo "friendly_name=MiniDLNA [${HOSTNAME}]" >>${CFG_FILE}
    fi

    # Correct the files ownership
    chown -R ${USER}:root ${SYNOPKG_PKGDEST}

    exit 0
}

preuninst ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Remove the user (if not upgrading)
    if [ "${SYNOPKG_PKG_STATUS}" != "UPGRADE" ]; then
        synouser --del ${USER}
    fi

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}

    exit 0
}

preupgrade ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${INSTALL_DIR}/var ${TMP_DIR}/${PACKAGE}/

    exit 0
}

postupgrade ()
{
    # Restore some stuff
    rm -fr ${INSTALL_DIR}/var
    mv ${TMP_DIR}/${PACKAGE}/var ${INSTALL_DIR}/
    rm -fr ${TMP_DIR}/${PACKAGE}

    exit 0
}
