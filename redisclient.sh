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

function configure_redisclient(){
    log INFO "Installing and Configuring Redis Client"

if [ ! -f $BIN_DIR/$RDIS_BIN_PATH ]; then
 log ERROR "Redis installables not found"
exit 1
fi

unzip $BIN_DIR/$RDIS_BIN_PATH -d $OPT/

cd $OPT/hiredis-1.0.2

make 

sudo make install	

log INFO "Redis Client installed and configured...."
}
function install_messaging(){
   configure_redisclient
}