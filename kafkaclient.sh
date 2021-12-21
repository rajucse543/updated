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

function configure_kafkaclient(){
    log INFO "Installing and Configuring Kafka Broker"

if [ ! -f $BIN_DIR/$KAFKA_BIN_PATH ]; then
 log ERROR "Kafa installables not found"
exit 1
fi

unzip $BIN_DIR/$KAFKA_BIN_PATH -d $OPT/

cd $OPT/librdkafka-master

log Info "Config Kafka Client"

$OPT/librdkafka-master/configure --prefix=/usr/local

make 

sudo make install	

log INFO "Kafka installed and configured...."
}

function install_messaging(){
   configure_kafkaclient
}