#!/bin/bash

TEMPFILE="fixnewlines.temp"

function fix-newlines() {
  local stfile="$1"
  echo "fixing $1"
  cat "$stfile" | tr $'\x0a' $'\x0d' > "$TEMPFILE"
  mv "$TEMPFILE" "$stfile"
}

for file in "$@"; do
  fix-newlines "$file";
done
