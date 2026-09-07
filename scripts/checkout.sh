#!/usr/bin/env bash
# Chromium 153 checkout + overlay + patches + gn gen (no APK).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="${HOME}/depot_tools:${ROOT}/depot_tools:${PATH}"
export ARGS_VARIANT="${ARGS_VARIANT:-release}"
exec "${ROOT}/ci/chromium_android_pipeline.sh" "$@"
