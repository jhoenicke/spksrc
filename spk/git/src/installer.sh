#!/bin/sh

# Package
PACKAGE="git"
DNAME="Git"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"


preinst ()
{
    exit 0
}

postinst ()
{
    # Links
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}
    mkdir -p /usr/local/bin
    ln -s ${INSTALL_DIR}/bin/git /usr/local/bin/git

    exit 0
}

preuninst ()
{
    exit 0
}

postuninst ()
{
    # Remove links
    rm -f ${INSTALL_DIR}
    rm -f /usr/local/bin/git

    exit 0
}

preupgrade ()
{
    exit 0
}

postupgrade ()
{
    exit 0
}
