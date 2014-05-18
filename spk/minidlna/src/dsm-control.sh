#!/bin/sh

# Package
PACKAGE="minidlna"
DNAME="miniDLNA"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:${PATH}"
USER="minidlna"
MINIDLNAD="${INSTALL_DIR}/sbin/minidlnad"
CFG_FILE="${INSTALL_DIR}/etc/minidlna.conf"
PID_FILE="${INSTALL_DIR}/var/minidlna.pid"

checkShares() {
	grep '^media_dir=' ${CFG_FILE} >/dev/null 2>&1
	if [ $? -eq 1 ]; then
		echo "Edit minidlna.conf (Menu) and add shares before starting." >${SYNOPKG_PKGDEST}/synology.out
		if [ $1 -eq 1 ]; then
			echo "Edit minidlna.conf (refresh DSM, top menu icon) and add shares before starting." >${SYNOPKG_TEMP_LOGFILE}
			exit 1
		fi
		if [ $1 -eq 2 ]; then
			echo "ERROR: add shares first, edit ${SYNOPKG_PKGDEST}/etc/minidlna.conf or use integrated CFE"
			exit 1
		fi
		return 0
	fi
	return 1
}

start_daemon ()
{
    su - ${USER} -s /bin/sh -c "${MINIDLNAD} -f ${CFG_FILE} -P ${PID_FILE} $1"
}

stop_daemon ()
{
    kill `cat ${PID_FILE}`
    wait_for_status 1 20 || kill -9 `cat ${PID_FILE}`
    rm -f ${PID_FILE}
}

daemon_status ()
{
    if [ -f ${PID_FILE} ] && kill -0 `cat ${PID_FILE}` > /dev/null 2>&1; then
        return
    fi
    rm -f ${PID_FILE}
    return 1
}

wait_for_status ()
{
    counter=$2
    while [ ${counter} -gt 0 ]; do
        daemon_status
        [ $? -eq $1 ] && return
        let counter=counter-1
        sleep 1
    done
    return 1
}


case $1 in
    start) checkShares 1
        if daemon_status; then
            echo ${DNAME} is already running
            exit 0
        else
            echo Starting ${DNAME} ...
            start_daemon ''
            exit $?
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
            exit $?
        else
            echo ${DNAME} is not running
            exit 0
        fi
        ;;
    restart) checkShares 1
        stop_daemon
        start_daemon ''
        exit $?
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    rescan) checkShares 2
	echo "starting MiniDLNA -R (ful rescan)"
        start_daemon -R
	;;
    *)
        exit 1
        ;;
esac
