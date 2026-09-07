# Features we keep from Kiwi

Afterbird already restored desktop Chrome extensions on Chromium 151 (`is_desktop_android=true` plus five patches). That is the behavior we ship, under our package ID. Relixor is the product feel we want (extensions-first, purple). Kiwi's extra UI (bottom bar, night mode, classic NTP) is backlog, not the first APK.

## Afterbird already verified (v1.9.1)

uBlock Origin (MV2), Dark Reader, Stylus, Violentmonkey, SponsorBlock, Bitwarden, uBO Lite. Chrome Web Store install works with the desktop UA patch. uBlock Origin scores 132/132 on adblock.turtlecute.org.

## Must keep

- Chrome Web Store / unpacked Chrome extensions on Android (Manifest V2 and V3)
- `chrome://extensions` and toolbar/menu access to extensions
- Bottom address bar
- Night mode (Kiwi's implementation, not stock Chromium dark theme)
- Built-in content filters (subresource_filter lists from kiwi-content-filters)
- Developer tools on device
- Classic new-tab tile grid
- Edge-swipe history, swipe-up tab switcher, always-on toolbar
- External download manager hand-off
- Bookmark import/export

## Must not keep

- Package ID `com.kiwibrowser.browser`
- Kiwi name/logo on public builds
- Calls to `*.kiwibrowser.com`, `find.kiwi`, `longbuild.find.kiwi`
- Microsoft Edge migration UI
- Kiwi Google API key placeholders (`KIWIBROWSER`, `42.apps.kiwibrowser.com`)
- Crowdin / Discord / Play Store release automation that belonged to Geometry OU

## Engine

Kiwi's last published APK is Chromium **137.0.7337.0** (April 2025). Current Chromium stable is **152.x**. An overlay frozen on 137 is not a supported browser. Track 2 is a rebase onto 152+ with the feature list above as the acceptance bar.
