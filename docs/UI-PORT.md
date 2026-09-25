# UI port — Lemur chrome, purple accent

Spec only. Do not compile until an explicit build command. Patch order and the locked `is_desktop_android = true` decision: [UI-PORT-PLAN.md](UI-PORT-PLAN.md).

The v1 APK is stock Chromium chrome (`is_desktop_android`) plus a Canopy name and launcher icon. This document is the work to make the next UI cut look and behave like **Lemur Browser** on a phone, with **Relixor purple** as the accent. Product name stays **Canopy**. Package stays `app.canopy.browser`.

## Look target

**Primary:** Lemur Browser (phone) — clean, extension-first, bottom chrome, tile homepage, AMOLED dark.

**Accent:** Relixor purple `#8000FF`.

**Behavior reference:** Kiwi / Relixor overlay in `vendor/relixor/` and `vendor/kiwi-src-next/` (bottom toolbar pref, night mode that darkens sites, extensions in the hamburger menu). Those trees are **Chromium 105**. They are a specification, not something to rsync onto 153.

Do not ship Lemur, Kiwi, Afterbird, or Relixor names, logos, package IDs, or network endpoints.

### What Lemur looks like (the bar we copy)

Phone, one-handed:

- Address bar and controls **at the bottom**. Always on (does not slide away on scroll).
- New-tab page is a **wallpaper + search + icon tile grid**. No Discover, no news feed, no promo cards.
- Tiles are user-editable (add, group, reorder). Homepage stays a homepage.
- Hamburger / overflow is one menu. Extensions are an obvious item, not buried. Do **not** copy Lemur’s split dual-menu (users call it confusing).
- Tab switcher: list and grid. Swipe-up on the toolbar opens it.
- Dark / AMOLED default. Optional “darken websites” (Kiwi night mode), not only Material dark chrome.
- Desktop site toggle. DevTools on device. Edge-swipe back/forward.

Tablet may keep a top bar. Phone default is bottom.

### What we do not copy from Lemur

| Lemur | Ours |
|---|---|
| Closed-source APK / Unsplash wallpaper CDN | Original NTP + local/user wallpapers later |
| Default search Baidu | User-chosen engine; no Baidu default |
| Dual overflow menus | One menu |
| Edge Add-ons as a second store in bookmarks | Chrome Web Store via existing desktop-UA patch; Edge store is later |
| Lemur / “Rabbit Nest” branding | Canopy |

`vendor/kiwi-classic-ntp/` is **CC BY-NC-SA**. Do not vendor that HTML into a build we might ship. Reimplement a tile NTP.

## Theme — purple, not unused sage tokens

v1 put Folio Calm Sage hexes in `branding/android/res_chromium_base/values/channel_constants.xml`. Chromium chrome never reads `brand_primary`. Launcher mipmaps can stay the user’s icons. **In-app chrome uses this palette:**

| Token | Hex | Use |
|---|---|---|
| `accent` | `#8000FF` | Toggles, progress, selected, focus ring, active tab pip |
| `accent_pressed` | `#6A00D6` | Pressed / ripple |
| `accent_container` | `#2A1048` | Selected chips, extension badge field |
| `surface` | `#0B0B10` | AMOLED page / NTP |
| `surface_high` | `#16141C` | Toolbar, menus, sheets |
| `on_surface` | `#F2F0F7` | Primary text/icons on dark |
| `on_accent` | `#FFFFFF` | Text on purple |
| `outline` | `#3D3450` | Hairlines |
| `paper` | `#F7F5FC` | Light mode surfaces only |

Rules:

- Default UI is **dark**. Light mode is supported, still purple accents.
- One accent. No sage, no Google Blue, no Relixor wordmark.
- Wire tokens into Chromium’s real theme resources (`default_text_color_accent1`, toolbar, omnibox, switches, NTP), not only `channel_constants.xml`.
- Incognito stays distinct (darker, no purple wash on the NTP tiles).

## Architecture — do not overlay Relixor onto 153

Afterbird (what v1 followed) is a thin delta: branding + extension patches. Relixor is a frozen Kiwi overlay on Chromium **105**. Dumping `vendor/relixor/chrome/` onto Chromium **153** will not apply.

Port **behaviors** as `patches/m153/` (+ branding resources), using 153 APIs:

| Need | 153 hook | Relixor/Kiwi reference |
|---|---|---|
| Bottom address bar | `ToolbarPositionController` (`chrome/browser/ui/android/toolbar/.../ToolbarPositionController.java`). Default **bottom** on phone. | Pref `enable_bottom_toolbar` in Relixor `ToolbarPhone`, `TabbedRootUiCoordinator`, `AppMenu` |
| Always-on toolbar | Disable auto-hide / browser-controls slide on phone | Relixor `enable_overscroll_button` / fullscreen manager |
| Tile NTP, no Discover | Replace Chrome NTP/feed with our NTP | `vendor/kiwi-classic-ntp/` as UX spec only; Relixor `new_tab_page_layout.xml` |
| Night mode + darken sites | Settings + `darken_websites_enabled` | Relixor `NightModeSettings`, `TabbedNavigationBarColorController` |
| Extensions in the menu | Already have Afterbird `0003` (`chrome://extensions` fallback). Add a visible **Extensions** row like Relixor `main_menu.xml` `@id/extensions_id` | Relixor `chrome/android/java/res/menu/main_menu.xml` |
| Tab switcher modes | Settings + existing tab UI | Relixor `tabswitcher_preferences.xml` |
| Edge-swipe / swipe-up | Gesture handlers on the toolbar/content | FEATURES.md must-keep; Relixor overlay |

`is_desktop_android = true` is why the current APK looks like desktop Chrome (tab strip). Afterbird turned it on so CWS extensions work. For this UI cut:

1. Keep Afterbird patches `0001`–`0006` (MV2, Web Store UA, unpacked uBlock).
2. Phone chrome must **not** show a desktop tab strip.
3. Prefer 153 phone UI + Afterbird extension stack. If `is_desktop_android` forces desktop chrome, turn it **off** on phone and keep the extension patches (0003 already handles a null desktop coordinator).

Do not reintroduce the 14-repo overlay as the working model. See [REPOS.md](REPOS.md).

## Work that must be done

Order is the acceptance order. Each slice is its own patch(es) under `patches/m153/`. No `--full-build` until asked.

### 1. Wire purple into real chrome

- Add the table above to Android color resources Chromium actually compiles (`ui/android` / `chrome/android` theme, not only `channel_constants.xml`).
- Toolbar, omnibox, switches, progress bar, selected tab, settings accents use `accent`.
- Drop unused Folio tokens from the overlay or stop pretending they theme the app.
- Verify light and dark. Check a settings page, NTP, and a normal tab.

### 2. Bottom bar, always on

- Default `ToolbarPositionController` to **bottom** on phone (tablet may stay top).
- Settings: Toolbar → Bottom / Top (Kiwi had this; Lemur phone has no top option — we keep the toggle).
- Toolbar does not hide on scroll.
- Overflow menu opens **upward** from the bottom control (Relixor `AppMenu` `EndIconMenuAnimBottom`).
- Omnibox suggestions grow upward when the bar is at the bottom.

### 3. Classic tile NTP (Lemur homepage)

- Kill Discover / feed / “most engaged” promo modules on the NTP.
- Homepage: search field, then a grid of site tiles. Optional static wallpaper later; not a remote Unsplash fetch.
- Tiles: add, remove, reorder. Default set is generic (search, CWS, settings) — no Kiwi/Lemur logos from `vendor/kiwi-logos/` unless license-cleared.
- Incognito NTP is a separate dark empty state, not the tile wall.

### 4. Extension-first chrome

- Overflow: **Extensions** near Bookmarks / History, puzzle-piece icon.
- That item opens `chrome://extensions` (Afterbird 0003) or the 153 extensions hub if present.
- Keep CWS install (0005 desktop UA) and baked uBlock (0006).
- Toolbar space for extension action icons when MV2 `browserAction` is loaded (Afterbird 0002). If 153 desktop-android is off, this is the hard part — do not ship a UI that has extensions but no way to click them.

### 5. Night mode (Kiwi, not stock dark theme)

- Settings → Appearance: System / Light / Dark, plus **Darken websites**.
- Darken websites is the Kiwi `darken_websites_enabled` behavior (invert/filter page content), not only `ui_theme_setting`.
- AMOLED: toolbar and NTP use `surface` `#0B0B10`, not grey 900.

### 6. Gestures and tab switcher

- Edge-swipe: history back / forward.
- Swipe-up on the toolbar: tab switcher.
- Tab switcher: list and grid (Relixor `TabSwitcherSettings`). Default grid on phone.
- Always-on toolbar still visible in the tab switcher.

### 7. Strip leftover Chrome product chrome

While touching those surfaces:

- No Google services promo on settings (already empty keys; hide the rows).
- No “What’s new”, tips, bottom-omnibox IPH once we default bottom.
- No Microsoft Edge migration (FEATURES.md).
- No `*.kiwibrowser.com` / `find.kiwi`.

## Files to start from

| Area | In this repo | On 153 |
|---|---|---|
| Purple tokens | `branding/android/res_chromium_base/values/channel_constants.xml` (today unused) | Theme overlays listed in `chrome/android/java/res_chromium_base` BUILD.gn |
| Bottom bar | Relixor `enable_bottom_toolbar` call sites | `ToolbarPositionController.java`, `ToolbarManager.java` |
| Menu | Relixor `res/menu/main_menu.xml` | 153 app menu delegate |
| Night mode | Relixor `res/xml/nightmode_preferences.xml`, `ChromeApplicationImpl` | 153 `ThemeSettingsFragment` + a darken-sites patch |
| NTP spec | `vendor/kiwi-classic-ntp/` (license: look, don’t copy) | 153 NTP Java/WebUI |
| Extension menu | Afterbird `patches/m153/0003-*.patch` | same |
| Legacy bottombar | `patches/legacy-kiwi/Add-bottombar-on-screen-part-{1,2,3}.patch` | Chromium 80; spec only |

## Done when

On a phone, without touching settings:

1. Bottom address bar, always visible.
2. New tab is a tile grid, not Chrome Discover.
3. Chrome is dark with purple accents (`#8000FF`), not Google Blue and not unused sage.
4. Overflow has Extensions; CWS and uBlock still work.
5. Night mode can darken web pages.
6. Name is Canopy. No Lemur/Kiwi/Relixor strings.

## Out of this port

- Rebuilding the APK
- Relixor/Kiwi/Lemur branding
- Trichrome / PGO size work ([BUILD.md](BUILD.md))
- Cromite/ungoogled privacy patches ([PRIVACY.md](PRIVACY.md))
- Play signing
- Linux desktop UI
- Copying Lemur’s closed-source resources
