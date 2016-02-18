#!/bin/sh

#
# Script options (exit script on command fail).
#
set -e

#
# Variables
#
USER="named"
GROUP="named"

#
# Display settings on standard out.
#
echo "named settings"
echo "=================="
echo
echo "  User:       ${USER}"
echo "  Group:      ${GROUP}"
echo "  UID:        ${NAMED_UID:=1000}"
echo "  GID:        ${NAMED_GID:=101}"
echo

#
# Change UID / GID of named user.
#
printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${NAMED_UID} ]] || usermod  -o -u ${NAMED_UID} ${USER}
[[ $(id -g ${GROUP}) == ${NAMED_GID} ]] || groupmod -o -g ${NAMED_GID} ${GROUP}
echo "[DONE]"

#
# Set owner and permissions.
#
printf "Set owner and permissions... "
chown -R ${USER}:${GROUP} /var/bind /etc/bind /var/run/named /var/log/named
chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/log/named
echo "[DONE]"

#
# Start named.
#
echo "Start named... "
/usr/sbin/named -u ${USER} -c /etc/bind/named.conf -f
echo "[DONE]"
