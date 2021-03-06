#!/bin/sh

# Package
PACKAGE="transmission"
DNAME="Transmission"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
PATH="${INSTALL_DIR}/bin:${PATH}"
USER="transmission"
GROUP="users"
CFG_FILE="${INSTALL_DIR}/var/settings.json"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

SERVICETOOL="/usr/syno/bin/servicetool"
FWPORTS="/var/packages/${PACKAGE}/scripts/${PACKAGE}.sc"

preinst ()
{
    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        if [ ! -d "${wizard_download_dir}" ]; then
            echo "Download folder ${wizard_download_dir} does not exist."
            exit 1
        fi
    fi
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

    # Create user
    synouser --add ${USER} `openssl rand 27 -base64 2>/dev/null` "${DNAME} User" 1 "" 0

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Edit the configuration according to the wizard
        sed -i -e "s|@download_dir@|${wizard_download_dir:=/volume1/downloads}|g" ${CFG_FILE}
        sed -i -e "s|@username@|${wizard_username:=admin}|g" ${CFG_FILE}
        sed -i -e "s|@password@|${wizard_password:=admin}|g" ${CFG_FILE}
        if [ -d "${wizard_watch_dir}" ]; then
            sed -i -e "s|@watch_dir_enabled@|true|g" ${CFG_FILE}
            sed -i -e "s|@watch_dir@|${wizard_watch_dir}|g" ${CFG_FILE}
        else
            sed -i -e "s|@watch_dir_enabled@|false|g" ${CFG_FILE}
            sed -i -e "/@watch_dir@/d" ${CFG_FILE}
        fi
        # Set group and permissions on download- and watch dir for DSM5
        if [ `/bin/get_key_value /etc.defaults/VERSION buildnumber` -ge "4418" ]; then
            chgrp users ${wizard_download_dir:=/volume1/downloads}
            chmod g+rw ${wizard_download_dir:=/volume1/downloads}
            if [ -d "${wizard_watch_dir}" ]; then
                chgrp users ${wizard_watch_dir}
                chmod g+rw ${wizard_watch_dir}
            fi
        fi
    fi
    if [ -d "${wizard_incomplete_dir}" ]; then
        sed -i -e "s|@incomplete_dir_enabled@|true|g" ${CFG_FILE}
        sed -i -e "s|@incomplete_dir@|${wizard_incomplete_dir}|g" ${CFG_FILE}
    else
        sed -i -e "s|@incomplete_dir_enabled@|false|g" ${CFG_FILE}
        sed -i -e "/@incomplete_dir@/d" ${CFG_FILE}
    fi

    # Correct the files ownership
    chown -R ${USER}:root ${SYNOPKG_PKGDEST}

    # Add firewall config
    ${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null

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

    # Remove firewall config
    if [ "${SYNOPKG_PKG_STATUS}" == "UNINSTALL" ]; then
        ${SERVICETOOL} --remove-configure-file --package ${PACKAGE}.sc >> /dev/null
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
