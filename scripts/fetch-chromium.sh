#!/usr/bin/env bash
# Fetch a Chromium Android checkout. Tens of GB. Not required for overlay edits.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PIN="${CHROMIUM_PIN:-137.0.7337.0}"
DEST="${CHROMIUM_DIR:-$ROOT/chromium}"
DEPOT="${DEPOT_TOOLS_DIR:-$ROOT/depot_tools}"

if [ "${1:-}" != "--yes" ]; then
  echo "This clones Chromium for Android at $PIN into $DEST."
  echo "Expect tens of GB and a long download."
  echo "Re-run with --yes to proceed. Override pin with CHROMIUM_PIN=..."
  exit 1
fi

if [ ! -x "$DEPOT/fetch" ]; then
  git clone --depth 1 https://chromium.googlesource.com/chromium/tools/depot_tools.git "$DEPOT"
fi

export PATH="$DEPOT:$PATH"
mkdir -p "$DEST"
cd "$DEST"

if [ ! -d src ]; then
  fetch --nohooks android
fi

cd src
git fetch origin "refs/tags/$PIN:refs/tags/$PIN" || git fetch --tags origin
git checkout -f "$PIN"
gclient sync --with_branch_heads --with_tags -D

echo "Chromium $PIN is in $DEST/src"
echo "Next: copy branding/args.gn to src/out/android_arm64/args.gn and gn gen."
