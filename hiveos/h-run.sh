#!/usr/bin/env bash
cd "$(dirname "$0")"
# Our own settings (config and log paths), whether or not HiveOS passed them on.
. ./h-manifest.conf
mkdir -p "$(dirname "$CUSTOM_LOG_BASENAME")"
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo "no $CUSTOM_CONFIG_FILENAME: apply the flight sheet again" && exit 1
exec ./glint $(cat "$CUSTOM_CONFIG_FILENAME") 2>&1 | tee "${CUSTOM_LOG_BASENAME}.log"
