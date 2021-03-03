#!/usr/bin/env bash

set -e
set -o pipefail

# write password to /data/etc/icinga2/conf.d/icingaweb-api-user.conf
if [ ! -f /data/etc/icinga2/conf.d/icingaweb-api-user.conf ]; then
    sed "s/\$ICINGAWEB_ICINGA2_API_USER_PASSWORD/${ICINGAWEB_ICINGA2_API_USER_PASSWORD:-icinga.web.password}/" /config/icingaweb-api-user.conf >/data/etc/icinga2/conf.d/icingaweb-api-user.conf
fi

# write /data/etc/icinga2/features-enabled/icingadb.conf
if [ ! -f /data/etc/icinga2/features-enabled/icingadb.conf ]; then
    mkdir -p /data/etc/icinga2/features-enabled
    cat /config/icingadb.conf >/data/etc/icinga2/features-enabled/icingadb.conf
fi
