# Facilitat Browser

Independent Chromium Android browser with Chrome extensions. Kiwi lineage, our implementation.

Not affiliated with Geometry OU, [Afterbird](https://github.com/danosito/afterbird), or [Relixor](https://github.com/Relixor/Relixor).

## Working identity

| | |
|---|---|
| Display name | Facilitat Browser (working title — rename before a public APK) |
| Application ID | `dev.facilitat.browser` |
| Engine | Chromium **151.0.7922.38** |
| Owner | [Facilitat-dev](https://github.com/Facilitat-dev) |

This repo is indexed by graft (`graft/`). Ask the graph before grepping.

## What we took, and from where

**Engineering base — [Afterbird](https://github.com/danosito/afterbird).** Most active Kiwi successor. Tiny delta over stock Chromium 151 with `is_desktop_android=true`, five patches, real APKs, Chrome Web Store install, uBlock Origin 132/132. GitHub will not let us fork it (already forked `src.next` in the same network), so it lives under `vendor/afterbird` and its patch series is copied into `patches/m151/`.

**Product direction — [Relixor](https://github.com/Relixor/Relixor).** The fork we want to feel like: extensions-first, clean/minimal, purple `#8000FF`. Relixor itself is still a frozen `src.next` overlay (Oct 2025, no APKs). We are not shipping their name or icons.

**Lineage — Kiwi.** Original org forked under Facilitat-dev as `kiwi-*`. Overlay identity cuts (no `*.kiwibrowser.com`, package ID change) live on [kiwi-src-next](https://github.com/Facilitat-dev/kiwi-src-next).

## Layout

```
patches/m151/   live Afterbird series (MV2, Web Store UA, phone menu)
patches/legacy-kiwi/   Chromium 80-era Kiwi patches (reference only)
branding/       identity.toml, GN args, Android string overlay
ci/             Afterbird Chromium Android pipeline
chrome/android/java/res_chromium_base  → branding overlay (pipeline path)
graft/          context graph
vendor/         local clones (gitignored): afterbird, relixor, kiwi-*
```

## Build

```bash
./scripts/clone-upstream.sh
# Tens of GB. Afterbird pipeline: pin 151.0.7922.38, apply patches/m151, gn gen.
AFTERBIRD_ARGS_VARIANT=release ./ci/chromium_android_pipeline.sh --full-build
```

Smoke-only (no ninja) is the default without `--full-build`. See [docs/BUILD.md](docs/BUILD.md).
