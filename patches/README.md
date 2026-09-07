# Patches

Live series is `m153/` against Chromium 153.0.8010.39 (Afterbird extension patches rebased + Canopy uBlock bundle). `m151/` is the Afterbird-verified copy. `legacy-kiwi/` is Chromium 80 reference.

## legacy-kiwi/

Copied from our forks of `kiwibrowser/patches` and `kiwibrowser/chromium_extension_patches`. GPL-3.0. Use them as the specification for extension-on-Android and the bottom toolbar while porting.

| File | Origin |
|---|---|
| `Add-support-for-extensions-on-Android.patch` | kiwi-patches |
| `0001-Kiwi-Introduce-extensions-support-R80-from-patches.patch` | kiwi-patches |
| `0001-Kiwi-Introduce-extensions-support-R80-chromium80.patch` | extension-patches (Chromium 80 port) |
| `0001-Kiwi-Introduce-extensions-support-R80-no-plugins.patch` | extension-patches |
| `Add-bottombar-on-screen-part-{1,2,3}.patch` | kiwi-patches |
| `Add-possibility-to-remove-AMP-from-search.patch` | kiwi-patches |

Track 1 (overlay) lives in the `kiwi-src-next` fork, not here.
