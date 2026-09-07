# Privacy

This fork is privacy-centric. Stock Chromium phones home. We do not.

## Build-time (GN)

Set in `.build/args/{test,release}.gn`:

- Empty Google API keys; `use_official_google_api_keys = false`
- `disable_fieldtrial_testing_config` — no Google experiment seeds
- `enable_reporting = false` — no crash/metrics pipeline
- No Hangouts, mDNS, remoting, VR/AR, contextual search
- `enable_bound_session_credentials = false` — no sync cookie refresh
- `enable_request_header_integrity = false` — no Google request attestation
- Widevine/DRM off; NaCl/PDF/plugins off

Ad blocking is uBlock Origin (MV2), not a Google list and not Kiwi's old subresource_filter server.

## Not yet (needs source patches after the 153 tree is in)

Cromite/ungoogled do more in-tree: domain substitution, disable Safe Browsing network, anti-fingerprinting, trampoline Google URLs. Those land in `patches/m153/` once `git apply --check` against the pin passes. Do not copy Cromite wholesale — it is GPL-2.0-or-later; our overlay is BSD-3-Clause. Import only flags and patches whose licenses we can ship.

## Product

- Package ID `dev.facilitat.browser` (not Kiwi, Afterbird, or Chrome)
- No `*.kiwibrowser.com` / `find.kiwi`
- Chrome Web Store UA override is for installing extensions, not telemetry
