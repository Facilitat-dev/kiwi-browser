# Facilitat Browser

Independent Chromium Android browser with Chrome extensions. Kiwi lineage, our implementation.

Not affiliated with Geometry OU, [Afterbird](https://github.com/danosito/afterbird), or [Relixor](https://github.com/Relixor/Relixor).

## Working identity

| | |
|---|---|
| Display name | Facilitat Browser (working title — rename before a public APK) |
| Application ID | `dev.facilitat.browser` |
| Engine | Chromium **153.0.8010.39** |
| Privacy | No Google keys, no field trials, no reporting (see [docs/PRIVACY.md](docs/PRIVACY.md)) |
| Owner | [Facilitat-dev](https://github.com/Facilitat-dev) |

This repo is indexed by graft (`graft/`). Ask the graph before grepping.

## What we took, and from where

**Engineering base — [Afterbird](https://github.com/danosito/afterbird).** Most active Kiwi successor. Tiny delta over stock Chromium 151 with `is_desktop_android=true`, five patches, real APKs, Chrome Web Store install, uBlock Origin 132/132. GitHub will not let us fork it (already forked `src.next` in the same network), so it lives under `vendor/afterbird` and its patch series is copied into `patches/m151/`.

**Product direction — [Relixor](https://github.com/Relixor/Relixor).** The fork we want to feel like: extensions-first, clean/minimal, purple `#8000FF`. Relixor itself is still a frozen `src.next` overlay (Oct 2025, no APKs). We are not shipping their name or icons.

**Lineage — Kiwi.** Original org forked under Facilitat-dev as `kiwi-*`. Overlay identity cuts (no `*.kiwibrowser.com`, package ID change) live on [kiwi-src-next](https://github.com/Facilitat-dev/kiwi-src-next).

## One repo

Kiwi split itself into 14 GitHub repos because their CI could not hold Chromium. That split is lineage, not a working model. **This repository is the only tree you work in.** Chromium is an external checkout at `chromium/` (gitignored). Why the 14 repos existed: [docs/REPOS.md](docs/REPOS.md).

```
patches/m153/     live series (Afterbird MV2/Web Store + privacy flags in GN)
patches/m151/     Afterbird-verified copies
patches/legacy-kiwi/  Chromium 80-era Kiwi patches (reference)
branding/         identity, GN args, Android strings
ci/               Chromium Android pipeline
chromium/         local engine checkout (not committed)
```

## Build

```bash
# First time: depot_tools + Chromium 153 tag + gclient sync. Tens of GB, long.
./ci/chromium_android_pipeline.sh
# APK
./ci/chromium_android_pipeline.sh --full-build
```

See [docs/BUILD.md](docs/BUILD.md) and [docs/PRIVACY.md](docs/PRIVACY.md).
