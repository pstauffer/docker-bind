#!/bin/sh -e

#
# Variables.
#
USER="named"
GROUP="named"

NAMED_UID_ACTUAL=$(id -u ${USER})
NAMED_GID_ACTUAL=$(id -g ${GROUP})

#
# Display settings on standard out.
#
echo "named settings"
echo "=============="
echo
echo "  Username:        ${USER}"
echo "  Groupname:       ${GROUP}"
echo "  UID actual:      ${NAMED_UID_ACTUAL}"
echo "  GID actual:      ${NAMED_GID_ACTUAL}"
echo "  UID prefered:    ${NAMED_UID:=1000}"
echo "  GID prefered:    ${NAMED_GID:=101}"
echo

#
# Change UID / GID of named user.
#
echo "Updating UID / GID... "
if [[ ${NAMED_GID_ACTUAL} -ne ${NAMED_GID} -o ${NAMED_UID_ACTUAL} -ne ${NAMED_UID} ]]
then
    echo "change user / group"
    deluser ${USER}
    addgroup -g ${NAMED_GID} ${GROUP}
    adduser -u ${NAMED_UID} -G ${GROUP} -h /etc/bind -g 'Linux User named' -s /sbin/nologin -D ${USER}
    echo "[DONE]"
else
    echo "[NOTHING DONE]"
fi

#
# Create rndc key
#
printf "Create rndc key"
if [ -s /etc/bind/rndc.key ]; then
    rm /etc/bind/rndc.key
fi
rndc-confgen -r /dev/urandom -a

#
# Set owner and group.
#
echo "Set owner and group... "
if [ ! -d /var/run/named ]; then
    mkdir -p /var/run/named
fi
chown ${USER}:${GROUP} /var/run/named
if [ ! -d /var/cache/bind ]; then
    mkdir -p /var/cache/bind
fi
chown ${USER}:${GROUP} /var/cache/bind
chown -R ${USER}:${GROUP} /etc/bind
echo "[DONE]"

#
# Start named.
#
echo "Start named... "
/usr/sbin/named -u ${USER} -c /etc/bind/named.conf -g &
echo "[DONE]"

#
# Start inotifywait
#
echo "Starting inotifywait... "
while inotifywait -e create,delete,modify,move -q /etc/bind; do rndc reload; done
