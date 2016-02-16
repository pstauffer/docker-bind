#!/bin/sh

#
# Display settings on standard out.
#

USER="named"

echo "named settings"
echo "=================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${NAMED_UID:=1000}"
echo "  GID:        ${NAMED_GID:=101}"
echo

#
# Change UID / GID of named user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${NAMED_UID} ]] || usermod  -o -u ${NAMED_UID} ${USER}
[[ $(id -g ${USER}) == ${NAMED_GID} ]] || groupmod -o -g ${NAMED_GID} ${USER}
echo "[DONE]"

#
# Set owner and permissions.
#

printf "Set owner and permissions... "
chown -R named:named /var/bind /etc/bind /var/run/named /var/log/named
chmod -R o-rwx /var/bind /etc/bind /var/run/named /var/log/named
echo "[DONE]"

#
# Finally, start named.
#

echo "Starting named... "
/usr/sbin/named -u named -c /etc/bind/named.conf -f
