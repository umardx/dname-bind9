#!/bin/sh

if [ -d /var/config/dname ]
then
  echo "/var/config/dname found; copying files to /etc/bind"
  cp -L /var/config/dname/* /etc/bind/
  chown -R bind:bind /etc/bind/
fi

# generate control channel key if requested
if [ ! -f /etc/bind/rndc.key ] && [ "${ENABLE_CONTROL_CHANNEL}" = "true" ]
then
  echo "/etc/bind/rndc.key not found; generating control channel key"
  rndc-confgen -a -u bind
elif [ ! -f /etc/bind/rndc.key ] && [ "${ENABLE_CONTROL_CHANNEL}" != "true" ]
then
  echo "/etc/bind/rndc.key not found; control channel not enabled"
else
  echo "/etc/bind/rndc.key found; skipping control channel key generation"
fi

named-checkconf /etc/bind/named.conf

echo "\n"

exec "${@}"
