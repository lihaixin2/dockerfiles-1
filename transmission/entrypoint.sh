#! /bin/sh
#
# entrypoint.sh

set -e

[[ "$DEBUG" == "true" ]] && set -x

mkdir -p /data/.config /data/.watch /data/downloads
chown -R transmission:transmission /data
[[ ! -f /data/.config/settings.json ]] && cp /etc/transmission/settings.json /data/.config/settings.json

exec "$@"
