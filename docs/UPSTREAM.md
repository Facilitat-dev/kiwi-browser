# Upstream map

## Successors we follow

| Project | Role | Why not a GitHub fork |
|---|---|---|
| [danosito/afterbird](https://github.com/danosito/afterbird) | Engineering base (Chromium 151 delta, v1.9.1) | Same fork network as `src.next` — GitHub allows one fork per network |
| [Relixor/Relixor](https://github.com/Relixor/Relixor) | Product direction (extensions-first, purple) | Same network |

Cloned locally as `vendor/afterbird` and `vendor/relixor`.

## Original Kiwi org

https://github.com/kiwibrowser

We forked every original Kiwi repository (not third-party Action/Flutter mirrors) onto Facilitat-dev and renamed them `kiwi-*`.

| Original | Our fork | Cloned locally | Notes |
|---|---|---|---|
| src.next | kiwi-src-next | yes | Overlay. Default branch `kiwi`. |
| src | kiwi-src | no | ~2.8 GB. Clone when you are ready to build. |
| src.canary | kiwi-src-canary | yes | Canary assets |
| android | kiwi-android | no | Archived, superseded by src |
| docker_image | kiwi-docker-image | yes | Ubuntu bionic + OpenJDK 8. Stale. |
| content_filters | kiwi-content-filters | yes | Ad lists |
| classic_ntp | kiwi-classic-ntp | yes | NTP (CC BY-NC-SA — check before commercial use) |
| extensions | kiwi-extensions | yes | Store HTML |
| logos | kiwi-logos | yes | Tile icons |
| sync | kiwi-sync | yes | GPL-2.0 sync extension |
| ia | kiwi-ia | yes | Instant answers |
| patches | kiwi-patches | yes | GPL-3.0 |
| chromium_extension_patches | kiwi-chromium-extension-patches | yes | GPL-3.0, Chromium 80 |
| dependencies | kiwi-dependencies | no | CIPD mirror |

Not forked (third-party mirrors): `actions_test_project`, `android-emulator-runner`, `cache`, `checkout`, `eruda`, `F12_New`, `plugins`.
