#!/usr/bin/env bash
# Apply patches/series onto a Chromium src tree.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SERIES="$ROOT/patches/series"
SRC="${1:-}"

if [ -z "$SRC" ] || [ ! -d "$SRC" ]; then
  echo "usage: $0 /path/to/chromium/src"
  exit 1
fi

if [ ! -s "$SERIES" ]; then
  echo "patches/series is empty. Legacy Kiwi patches are in patches/legacy-kiwi/ and do not apply to modern Chromium."
  exit 1
fi

cd "$SRC"
while IFS= read -r patch || [ -n "$patch" ]; do
  [[ -z "$patch" || "$patch" =~ ^# ]] && continue
  echo "applying $patch"
  git apply --check "$ROOT/patches/$patch"
  git apply "$ROOT/patches/$patch"
done < "$SERIES"
