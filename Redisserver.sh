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

function configure_redisserver(){
    log INFO "Installing and Configuring Redis Server"

if [ ! -f $BIN_DIR/$RDIS_Server_BIN_PATH ]; then
 log ERROR "Redis Server installables not found"
exit 1
fi

tar -xvzf $BIN_DIR/$RDIS_Server_BIN_PATH -C $OPT/

cd $OPT/redis-stable

sudo make

sudo make test

sudo make install

mkdir /etc/redis

cp $OPT/redis-stable/redis.conf /etc/redis

"[Unit]
Description=Redis In-Memory Data Store
After=network.target

[Service]
ExecStart=/usr/local/bin/redis-server /etc/redis/redis.conf
ExecStop=/usr/local/bin/redis-cli shutdown
Restart=always

[Install]

WantedBy=multi-user.target" > /etc/systemd/system/redis.service

mkdir /var/lib/redis


sed -e '/^supervised no/supervised systemd/'  -e 's/^# *bind 127\.0\.0\.1 ::1/bind 127.0.0.1 ::1'  /etc/redis/redis.conf >/etc/redis/redis.conf.new

mv /etc/redis/redis.conf.new /etc/redis/redis.conf


log INFO "Starting Redis server...."

systemctl start redis
	

log INFO "Redis Server installed and configured...."
}
function install_messaging(){
   configure_redisserver
}