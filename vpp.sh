#!/bin/sh
# ********************************************************************
# Name    : install_messaging.lib
# Date    : 06/12/2021
# Revision: 0.1
           # Purpose : Installs and configures the Messaging subsystem.
#
# Usage   : source install_messaging.lib
#
# ********************************************************************

# Ensure script is sourced and not executed
[[ "${BASH_SOURCE[0]}" = "${0}" ]] && { echo "${0} must be sourced, NOT executed"  ; exit 1; }

# Ensure file is only sourced once
[ -n "$INSTALL_MESSAGING_SOURCED" ]  && return
export INSTALL_MESSAGING_SOURCED=true

function configure_vpp(){
    log INFO "Installing and Configuring VPP"

if [ ! -f $BIN_DIR/$VPP_BIN_PATH ]; then
 log ERROR "VPP installables not found"
exit 1
fi

tar -xvzf $BIN_DIR/$VPP_BIN_PATH -C $OPT/

cd $OPT/vpp
dpkg -l | grep vpp
dpkg -l | grep DPDK
make install-dep
make build
make build-release
make pkg-rpm
ls *.deb
sudo bash
dpkg -i *.deb$ sudo bash
rpm -ivh *.rpm

log INFO "VPP installed and configured...."
}

function install_messaging(){
   configure_vpp
}