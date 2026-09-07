#!/usr/bin/env bash
# Rasterize Canopy launcher mipmaps from branding/canopy-branding/logos/canopy-app-icon.svg
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SVG="$ROOT/branding/canopy-branding/logos/canopy-app-icon.svg"
OVERLAY="$ROOT/branding/android/res_chromium_base"
[[ -f "$SVG" ]] || { echo "missing $SVG" >&2; exit 1; }

raster() { rsvg-convert -w "$2" -h "$2" "$SVG" -o "$1"; }
bg() { magick -size "${2}x${2}" "xc:#181C1A" PNG32:"$1"; }

declare -A APP=([mdpi]=48 [hdpi]=72 [xhdpi]=96 [xxhdpi]=144 [xxxhdpi]=192)
declare -A LAYER=([mdpi]=108 [hdpi]=162 [xhdpi]=216 [xxhdpi]=324 [xxxhdpi]=432)

for dens in mdpi hdpi xhdpi xxhdpi xxxhdpi; do
  d="$OVERLAY/mipmap-$dens"
  mkdir -p "$d"
  raster "$d/app_icon.png" "${APP[$dens]}"
  raster "$d/layered_app_icon.png" "${LAYER[$dens]}"
  bg "$d/layered_app_icon_background.png" "${LAYER[$dens]}"
done
mkdir -p "$ROOT/branding/canopy-branding/export"
raster "$ROOT/branding/canopy-branding/export/app-icon-512.png" 512
echo "wrote mipmaps under $OVERLAY"
