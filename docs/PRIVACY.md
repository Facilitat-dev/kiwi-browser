# Privacy

This fork is privacy-centric. Stock Chromium phones home. We do not.

## Build-time (GN)

Set in `.build/args/{test,release}.gn`:

- Empty Google API keys; `use_official_google_api_keys = false`
- `disable_fieldtrial_testing_config` — no baked-in field-trial testing config. Finch seed fetch is already skipped because the build is not Chrome-branded. `X-Client-Data` is removed in patch `0032`.
- `enable_reporting = false` — Network Error Logging / Reporting API, not UMA. Metrics and crash upload are opt-in in patch `0033`.
- No Hangouts, mDNS, remoting, VR/AR, contextual search
- `enable_bound_session_credentials = false` — no sync cookie refresh
- `enable_request_header_integrity = false` — no Google request attestation
- Widevine/DRM off; NaCl/PDF/plugins off

Ad blocking is uBlock Origin (MV2), not a Google list and not Kiwi's old subresource_filter server.

## This slice

`0031`–`0036` and [PRIVACY-HARDENING.md](PRIVACY-HARDENING.md) cover the low-risk phone-home defaults: updater pings, `X-Client-Data`, suggest/feed/domain-reliability/network-time prefs, metrics opt-in, DuckDuckGo as the fallback search engine, a first-run search choice (Google still selectable), and Safe Browsing that does not send page URLs. `0037`–`0039` stay free inside this range. Do not use `0040+` here.

## Not yet

Still later: local Safe Browsing hash-prefix lists, domain substitution, anti-fingerprinting, Google URL trampolines, sign-in promo removal, and a translate default. Do not copy Cromite wholesale — it is GPL-2.0-or-later; our overlay is BSD-3-Clause. Import only flags and patches whose licenses we can ship. Cite prior art; do not vendor it.

## Product

- Package ID `app.canopy.browser` (not Kiwi, Afterbird, or Chrome)
- No `*.kiwibrowser.com` / `find.kiwi`
- Chrome Web Store UA override is for installing extensions, not telemetry
