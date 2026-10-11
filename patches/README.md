# Patches

Live series is `m153/` against Chromium 153.0.8010.39 (Afterbird extension patches rebased + Canopy uBlock bundle + purple chrome tokens). `m151/` is the Afterbird-verified copy. `legacy-kiwi/` is Chromium 80 reference.

`0031`–`0036` are the privacy slice: no component-updater pings, no `X-Client-Data`, opt-in metrics, Discover/suggest off, DuckDuckGo as the fallback search engine, a first-run search choice, and Safe Browsing that does not upload page URLs. `0019`–`0030` and `0040+` are other slices. `is_desktop_android` stays true. Chrome Web Store installs keep `UpdateUrl()` and patch `0005`.

`0012` adds the purple / AMOLED color resources Chromium compiles. `0013` points chrome theme roles (accent, toolbar, omnibox, switches, NTP, settings) at those resources, defaults the UI to dark, and keeps incognito on a darker neutral surface. `0014`–`0016` put the phone toolbar at the bottom, keep it from sliding off on scroll, and open the app menu upward. `0017`–`0018` keep the overflow Extensions row and host extension action icons on the phone toolbar. None of these patches change `is_desktop_android`.

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
