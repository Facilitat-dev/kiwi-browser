#!/usr/bin/env bash
# Clone the working-set Kiwi forks into vendor/. Skips multi-GB trees.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VENDOR="$ROOT/vendor"
mkdir -p "$VENDOR"

# Afterbird / Relixor are not GitHub-forkable (same network as src.next).
clone_ref() {
  local dest="$1" url="$2" branch="$3"
  if [ -d "$VENDOR/$dest/.git" ]; then
    echo "already cloned: $dest"
    return
  fi
  echo "cloning $url ($branch)"
  git clone --depth 1 --branch "$branch" "$url" "$VENDOR/$dest"
}

clone_ref afterbird https://github.com/danosito/afterbird.git afterbird
clone_ref relixor https://github.com/Relixor/Relixor.git kiwi

WORKING=(
  kiwi-src-next
  kiwi-patches
  kiwi-chromium-extension-patches
  kiwi-docker-image
  kiwi-content-filters
  kiwi-classic-ntp
  kiwi-extensions
  kiwi-logos
  kiwi-sync
  kiwi-ia
  kiwi-src-canary
)

LARGE=(
  kiwi-src
  kiwi-android
  kiwi-dependencies
)

for repo in "${WORKING[@]}"; do
  dest="$VENDOR/$repo"
  if [ -d "$dest/.git" ]; then
    echo "already cloned: $repo"
    continue
  fi
  echo "cloning Facilitat-dev/$repo"
  git clone --depth 1 "https://github.com/Facilitat-dev/${repo}.git" "$dest"
done

echo
echo "Skipped large forks (clone only when you need a full build):"
printf '  %s\n' "${LARGE[@]}"
echo "Working set is in $VENDOR"
