# Build

A full Chromium Android build needs a 64-bit Linux machine, ~100 GB disk, and several hours.

## Path we actually use (Afterbird / Chromium 151)

This repo is a **delta**, not a Chromium checkout. Compilation happens in an external tree pinned to `CHROMIUM_VERSION` (`151.0.7922.38`).

```bash
# Default: checkout + sync + overlay + git apply patches/m151 + gn gen + graph check
./ci/chromium_android_pipeline.sh

# Real APK
AFTERBIRD_ARGS_VARIANT=release ./ci/chromium_android_pipeline.sh --full-build
```

The pipeline rsyncs `chrome/android/java/res_chromium_base` (our strings) and applies `patches/m151/*.patch`. GN args: `.build/args/test.gn` (debuggable, harness) or `.build/args/release.gn` (`is_official_build=true`). Both set `is_desktop_android = true` and `chrome_public_manifest_package = "dev.facilitat.browser"`.

## What the five patches do

| Patch | Why |
|---|---|
| `0001-mv2-reenable` | MV2 (uBlock Origin) is not treated as deprecated |
| `0002-browseraction-schema` | MV2 backgrounds can load `browserAction` / `pageAction` |
| `0003-extensions-menu-npe` | Phone form factor opens `chrome://extensions` instead of crashing |
| `0004-unpacked-without-devmode` | Load unpacked extensions without the desktop developer-mode toggle |
| `0005-webstore-desktop-ua` | Chrome Web Store shows Install instead of "Available on desktop" |

## Package ID

Public APKs must use `dev.facilitat.browser`. Do not ship `com.kiwibrowser.browser`, `com.danosito.afterbird`, or Relixor's ID.
