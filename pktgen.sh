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

function configure_packetgen(){
    log INFO "Installing and Configuring Packet Gen"

if [ ! -f $BIN_DIR/$PCKGEN_BIN_PATH ]; then
 log ERROR "Pkt Gen installables not found"
exit 1
fi

tar -xvzf $BIN_DIR/$PCKGEN_BIN_PATH -C $OPT/

sudo apt-get install lua

cd $OPT/$PCKGEN_DIR

make

sudo ./app/pktgen -l 0-4 -n 3 -- -P -m "[1:3].0" 

log INFO "Packet Gen installed and configured...."
}

function install_messaging(){
   configure_packetgen
}