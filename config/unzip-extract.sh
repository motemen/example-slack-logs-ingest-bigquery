#!/bin/bash

set -e -o pipefail
shopt -s nullglob

for zip in /data/*.zip; do
  echo "==> Unzipping $zip ..." >&2
  unzipped_dir="/tmp/$(basename "$zip")"
  unzip -o -q "$zip" -d "$unzipped_dir"
  for channel_dir in "$unzipped_dir"/*; do
    ch=$(basename "$channel_dir")
    /bin/echo -n "--> $ch " >&2
    for file in "$channel_dir"/*.json; do
        /bin/echo -n "." >&2
        jq -c --arg ch "$ch" 'map(. + {channel: $ch}) | .[]' "$file"
    done
    /bin/echo >&2
  done
done