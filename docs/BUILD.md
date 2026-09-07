# Build

A full Chromium Android build needs a 64-bit Linux machine, ~100 GB disk, and several hours.

## Path we actually use (Afterbird / Chromium 151)

This repo is a **delta**, not a Chromium checkout. Compilation happens in `chromium/` (gitignored), pinned to `CHROMIUM_VERSION` (`153.0.8010.39`).

```bash
# Checkout + sync + overlay + patches/m153 + gn gen + graph check
./ci/chromium_android_pipeline.sh

# Real APK (16 GB RAM: the pipeline caps ninja jobs)
./ci/chromium_android_pipeline.sh --full-build
```

The pipeline rsyncs `chrome/android/java/res_chromium_base` and applies `patches/m153/*.patch`. GN args: `.build/args/test.gn` or `.build/args/release.gn`. Both set `is_desktop_android = true`, `chrome_public_manifest_package = "dev.facilitat.browser"`, and the privacy flags in [PRIVACY.md](PRIVACY.md).

Default workspace: `chromium/` in this repo. Override with `CHROMIUM_WORKDIR`.

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
