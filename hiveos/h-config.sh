#!/usr/bin/env bash
# Builds glint.conf (the command line) from the Flight Sheet:
#   Wallet/template: your address (prl1... or COIN:address), Pool URL: optional (auto by default),
#   Pass: ignored, Extra config arguments: any glint flags, e.g. --kwh-price 0.12 --profit-mode
[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${RED}CUSTOM_TEMPLATE (wallet) is empty${NOCOLOR}" && exit 1
conf="--wallet $CUSTOM_TEMPLATE --worker ${WORKER_NAME:-rig} --plain --no-log-file --config /hive/miners/custom/glint/glint.json"
[[ -n $CUSTOM_URL ]] && conf+=" --pool $CUSTOM_URL"
[[ -n $CUSTOM_USER_CONFIG ]] && conf+=" $CUSTOM_USER_CONFIG"
echo "$conf" > "$CUSTOM_CONFIG_FILENAME"
