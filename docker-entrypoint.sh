#!/bin/bash

set -e -o pipefail

preprocessed_json_dir="/tmp/preprocessed_json"
mkdir -p "$preprocessed_json_dir"

for zip in /data/*.zip; do
  json_dir="/tmp/$(basename "$zip")"
  echo "# unzip $zip" >&2
  unzip -o -q "$zip" -d "$json_dir"
  for file in "$json_dir"/*/*.json; do
    ch=$(basename "$(dirname "$file")")
  	echo "# $ch" >&2
    jq -c --arg ch "$ch" 'map(. + {channel: $ch})' "$file" > "$preprocessed_json_dir/$ch--$(basename "$file")"
  done
done

PREPROCESSED_JSON_DIR=$preprocessed_json_dir embulk run /config/embulk.yml.liquid
