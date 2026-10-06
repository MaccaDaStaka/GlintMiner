#!/usr/bin/env bash
cd "$(dirname "$0")"
# Our own settings (config and log paths), whether or not HiveOS passed them on.
. ./h-manifest.conf
mkdir -p "$(dirname "$CUSTOM_LOG_BASENAME")"
# Keep the last two runs' logs (glint.log.1, glint.log.2): a restart must not wipe the log that says why it happened.
LOG="${CUSTOM_LOG_BASENAME}.log"
[[ -f "$LOG.1" ]] && mv -f "$LOG.1" "$LOG.2"
[[ -f "$LOG" ]] && mv -f "$LOG" "$LOG.1"
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo "no $CUSTOM_CONFIG_FILENAME: apply the flight sheet again" && exit 1
# A GlintMiner from this folder still running here was left behind: HiveOS stops the miner before it starts it, and
# one that stopped responding could outlive that (a tester's rig, 2 Oct: it kept the dashboard port and the cards).
# Asked to close first (it puts the cards' clocks back), ended after 15 s. Only this folder's glint, never another.
stale_glint() {
  local me exe p
  me="$(pwd -P)/glint"
  # Processes named glint (its program file's name), each checked by the program file it runs.
  for p in $(pgrep -x glint 2>/dev/null); do
    exe=$(readlink "/proc/$p/exe" 2>/dev/null) || continue
    exe=${exe% (deleted)}
    [[ $exe == "$me" ]] && echo "$p"
  done
}
stale=$(stale_glint)
if [[ -n $stale ]]; then
  echo "an earlier GlintMiner from this folder is still running (process $(echo $stale)); closing it first"
  kill -TERM $stale 2>/dev/null
  for _ in $(seq 15); do
    [[ -z $(stale_glint) ]] && break
    sleep 1
  done
  stale=$(stale_glint)
  [[ -n $stale ]] && echo "it didn't close; ending it (process $(echo $stale))" && kill -KILL $stale 2>/dev/null && sleep 2
fi
# One argument per line (h-config.sh); a glint.conf from before 1.2.8 is one line, split on spaces. Never expanded
# as wildcards either way.
set -f
args=()
if (( $(wc -l < "$CUSTOM_CONFIG_FILENAME") <= 1 )); then
  read -r -a args < "$CUSTOM_CONFIG_FILENAME"
else
  mapfile -t args < "$CUSTOM_CONFIG_FILENAME"
fi
exec ./glint "${args[@]}" 2>&1 | tee "$LOG"
