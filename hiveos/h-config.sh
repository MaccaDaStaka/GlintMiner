#!/usr/bin/env bash
# Builds glint.conf (glint's arguments, one per line) from the Flight Sheet:
#   Wallet/template: your address (prl1... or COIN:address), Pool URL: optional (auto by default),
#   Pass: ignored, Extra config arguments: any glint flags, e.g. --kwh-price 0.12 --profit-mode
[[ -z $CUSTOM_CONFIG_FILENAME ]] && . "$(dirname "${BASH_SOURCE[0]}")/h-manifest.conf"
[[ -z $CUSTOM_TEMPLATE ]] && echo -e "${RED}CUSTOM_TEMPLATE (wallet) is empty${NOCOLOR}" && exit 1
# The pool accepts letters, digits, - and _ in a worker name (as setup does); anything else is dropped.
worker=$(printf %s "${WORKER_NAME:-rig}" | tr -cd 'A-Za-z0-9_-'); [[ -z $worker ]] && worker=rig
# glint.conf holds one argument per line: h-run.sh passes each line as one argument, never split again or expanded
# (a * or ? in a value stays as typed). Written to a temporary file first, so a failure leaves the old one in place.
tmp="$CUSTOM_CONFIG_FILENAME.new"
{
  printf '%s\n' --wallet "$CUSTOM_TEMPLATE" --worker "$worker" --plain --no-log-file --config /hive/miners/custom/glint/glint.json
  [[ -n $CUSTOM_URL ]] && printf '%s\n' --pool "$CUSTOM_URL"
  # Extra config arguments split as a shell splits words ("quoted values" stay one argument), but nothing in them is
  # run or expanded: xargs only splits.
  if [[ -n $CUSTOM_USER_CONFIG ]]; then
    printf '%s' "$CUSTOM_USER_CONFIG" | xargs -r printf '%s\n' || { rm -f "$tmp"; echo -e "${RED}Extra config arguments: a quote isn't closed${NOCOLOR}"; exit 1; }
  fi
  true
} > "$tmp" || { rm -f "$tmp"; exit 1; }
mv -f "$tmp" "$CUSTOM_CONFIG_FILENAME"
