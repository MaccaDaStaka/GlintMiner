#!/usr/bin/env bash
cd "$(dirname "$0")"
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo "no $CUSTOM_CONFIG_FILENAME" && exit 1
exec ./glint $(cat "$CUSTOM_CONFIG_FILENAME") 2>&1 | tee "${CUSTOM_LOG_BASENAME}.log"
