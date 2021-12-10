#!/usr/bin/env bash

[[ -n $1 ]] || { echo input json file not specified; exit 1; }

INPUT=$1
DATE=$(date +%F'T'%T%z)

mkdir -p imported
LENGTH=$(jq '. | length' $INPUT)

echo "[INFO] Processing $LENGTH entries"

while [[ ${iter} < $LENGTH ]]; do
  TITLE="$(jq -r "[ .[] | select(.)][${iter:-0}].title" $INPUT)"
  TAGS="$(jq -r "[ .[] | select(.)][${iter:-0}].tags" $INPUT)"
  sed -e "s/<TITLE>/$TITLE/" \
      -e "s/<TAG>/$TAGS/" \
      -e "s/<DATE>/$DATE/" \
      -e "/^''/s/''/**/g" tmplt.md \
      <(jq -r "[ .[] | select(.)][${iter:-0}].text" $INPUT) \
      > "imported/${TITLE}.md" &&
      echo "[ OK ] imported/${TITLE}.md" ||
      echo "[FAIL] imported/${TITLE}.md"
  let iter++
done

