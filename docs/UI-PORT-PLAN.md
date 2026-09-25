# UI-port patch plan (Lemur chrome)

Concrete `patches/m153/` plan for [UI-PORT.md](UI-PORT.md). Spec rule: write patches; **do not** `--full-build` until Kyle asks.

**Locked decisions**
- Keep `is_desktop_android = true` so Chrome Web Store / extension install stays first-class (Afterbird path). Lemur phone chrome must land **on top of** desktop-android — do **not** add a GN patch that turns the flag off on phone.
- Afterbird `0001`–`0006` stay as-is (MV2, CWS desktop UA, uBlock, null-coordinator → `chrome://extensions`).
- Relixor / legacy-kiwi are behavior specs only (Chromium 105 / ~80). Do not rsync onto 153.
- Do not vendor `vendor/kiwi-classic-ntp/` (CC BY-NC-SA). Reimplement tile NTP.
- Product name stays **Canopy**; package `app.canopy.browser`. No Lemur / Kiwi / Relixor / Afterbird branding in ship.

**Current series:** `patches/m153/0001`–`0011` (extensions + build fixes). **Next free:** `0012`.
None of slices 1–7 are implemented yet (0003 only covers null-coordinator fallback).

**Accept bar on every UI slice:** extensions remain installable and their actions remain clickable.

**Suggested land order:** 1 → 2 → 4 → 3 → 5 → 6 → 7  
(Dropped planned `0022-desktop-android-phone-chrome-gn.patch`.)

---

## Slice 1 — Purple into real chrome

**Patches:** `0012-canopy-purple-theme-tokens.patch`, `0013-canopy-purple-wire-chrome-surfaces.patch`

**Do**
- Replace Folio sage in `branding/android/.../channel_constants.xml` and `branding/identity.toml` with UI-PORT palette (`accent` `#8000FF`, `accent_pressed` `#6A00D6`, `accent_container` `#2A1048`, `surface` `#0B0B10`, `surface_high` `#16141C`, `on_surface` `#F2F0F7`, `on_accent` `#FFFFFF`, `outline` `#3D3450`, `paper` `#F7F5FC`).
- Overlay / patch Chromium theme resources chrome actually reads (`default_text_color_accent1`, toolbar, omnibox, switches, NTP, settings) — not only `channel_constants.xml`.
- Default UI dark; light mode still purple accents. Incognito: darker, no purple wash on NTP tiles.
- Launcher mipmaps can stay as-is.

**Accept:** settings + NTP + normal tab show `#8000FF`, not Google Blue / sage.

---

## Slice 2 — Bottom bar, always on

**Patches:** `0014-toolbar-default-bottom-phone.patch`, `0015-toolbar-always-on-no-autohide.patch`, `0016-appmenu-omnibox-grow-upward.patch`

**Do**
- Hook 153 `ToolbarPositionController` + `AddressBarPreference` / pref `Chrome.Toolbar.TopAnchored`. Default **bottom** on phone; tablet may stay top. Keep Settings Top/Bottom toggle.
- Disable browser-controls slide / auto-hide on phone.
- App menu opens upward when bottom (define `EndIconMenuAnimBottom`-style; Relixor references it but XML is missing in vendor).
- Omnibox suggestions grow into upper viewport when bottom.

**Refs:** `chromium/.../ToolbarPositionController.java`; Relixor `ToolbarPhone.java`, `AppMenu.java`, `OmniboxSuggestionsDropdown.java`; legacy-kiwi bottombar parts 1–3 (pref pattern only).

**Accept:** cold start phone = bottom bar always visible; menu/suggestions open upward.

---

## Slice 3 — Classic tile NTP

**Patches:** `0017-ntp-disable-feed-discover.patch`, `0018-ntp-tile-homepage.patch`, `0019-ntp-incognito-empty-state.patch`

**Do**
- Kill Discover / feed / promo modules (`FeedSurfaceCoordinator` in `NewTabPage.java` / related flags).
- Restyle Most Visited tile stack as homepage grid (add/remove/reorder). Default tiles: generic search, CWS, settings.
- No Unsplash CDN. Incognito NTP: separate dark empty state.
- UX ref: Relixor `new_tab_page_layout.xml` — reimplement, don’t copy kiwi-classic-ntp HTML.

**Accept:** new tab = tile grid; no Discover; incognito empty/dark.

---

## Slice 4 — Extension-first chrome

**Patches:** `0020-appmenu-extensions-row.patch`, `0021-extension-action-icons-phone.patch`

**Do**
- Visible overflow **Extensions** row (Relixor `main_menu.xml` `@id/extensions_id`). Wire to 0003 path.
- Keep 0005 / 0006. Toolbar space for MV2 `browserAction` icons under desktop-android (helps this slice).
- Do not ship UI with extensions but no way to invoke actions.

**Accept:** Overflow → Extensions works; CWS + uBlock still work; action icons reachable on phone.

---

## Slice 5 — Night mode (Kiwi darken)

**Patches:** `0023-theme-default-amoled-dark.patch`, `0024-darken-websites-setting.patch`

**Do**
- Default dark; toolbar/NTP use `surface` `#0B0B10`.
- Settings → Appearance: System / Light / Dark + **Darken websites** via 153 `WebContentsDarkModeController` + `AUTO_DARK_WEB_CONTENT` (Relixor nightmode UX is spec only).

**Accept:** dark by default; Darken websites filters page content.

---

## Slice 6 — Gestures and tab switcher

**Patches:** `0025-edge-swipe-history.patch`, `0026-toolbar-swipe-up-tab-switcher.patch`, `0027-tab-switcher-list-grid-setting.patch`

**Do**
- Edge-swipe back/forward (`gesturenav`); Relixor `side_swipe_mode_enabled` default true as product behavior.
- Swipe-up on toolbar → tab switcher.
- List vs grid setting; default **grid** on phone. Always-on toolbar still visible in switcher (slice 2).

**Accept:** edge-swipe history; swipe-up opens switcher; grid default on phone.

---

## Slice 7 — Strip leftover Chrome product chrome

**Patches:** `0028-hide-google-promo-rows.patch`, `0029-suppress-bottom-omnibox-iph.patch`, `0030-strip-edge-migration-and-kiwi-endpoints.patch`

**Do**
- Hide Google services promo rows; suppress What’s new / tips / bottom-omnibox IPH; no Edge migration; no `*.kiwibrowser.com` / `find.kiwi`.

**Accept:** cold open has no promo/IPH/Edge/kiwi chrome; Canopy-only strings.

---

## Done when (UI-PORT)

On a phone, without touching settings: bottom always-on bar; tile NTP; dark purple `#8000FF`; Extensions in overflow + CWS/uBlock; darken-websites; Canopy-only branding.

## Out of this port

APK rebuild, Relixor/Kiwi/Lemur branding, Trichrome/PGO, Cromite, Play signing, Linux UI, Lemur APK assets.
