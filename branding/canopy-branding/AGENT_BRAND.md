# Canopy — Agent Brand Kit

Use this file as the source of truth when generating UI, copy, icons, slides, store listings, or docs for **Canopy**, a privacy-centric browser for Android and Linux.

Companion files:
- `tokens/tokens.json` — machine-readable colors, type, logo roles
- `tokens/folio-calm-sage-swatches.svg` — previous sage sheet; do not use for chrome
- `logos/` — marks, lockups, glyph, narrative emblem

---

## 1. What Canopy is

Canopy is a **quiet, protective browser**. It does not sell attention. It does not look like a VPN ad, a crypto wallet, or a military product.

Metaphor: a **living canopy** over the reader — cover, shade, growth — combined with a **guardian** (helmet / shield) and **private knowledge** (book, locked cubes).

Product name is always **Canopy**. Never “Canopy Browser” in the wordmark. In running text: “the Canopy browser” is fine.

## 2. Personality

| Be | Do not be |
|---|---|
| Calm | Hypey |
| Precise | Vague “next-gen” |
| Protective | Paranoid / fear-selling |
| Literate | Bro-tech, leet-speak |
| Grounded, analog-warm | Neon hacker, matrix rain |
| Adult | Cute mascot, playful stickers |

Voice example — good: “Trackers stay outside the canopy.”
Voice example — bad: “UNLEASH MILITARY-GRADE ANONYMITY!!!”

## 3. Color — Canopy purple / AMOLED

In-app chrome uses this palette (`branding/identity.toml`). One accent. No sage, no Google Blue.

| Token | Hex | Use |
|---|---|---|
| `accent` | `#8000FF` | Toggles, progress, selected, focus, active tab |
| `accent_pressed` | `#6A00D6` | Pressed / ripple |
| `accent_container` | `#2A1048` | Selected chips, extension badge field |
| `surface` | `#0B0B10` | AMOLED page / NTP |
| `surface_high` | `#16141C` | Toolbar, menus, sheets |
| `on_surface` | `#F2F0F7` | Primary text and icons on dark |
| `on_accent` | `#FFFFFF` | Text on purple |
| `outline` | `#3D3450` | Hairlines |
| `paper` | `#F7F5FC` | Light mode surfaces only |

Rules:
- Default product UI is **dark** (`surface` + `on_surface`). Light mode uses `paper` and still uses `accent`.
- Primary buttons: `accent` fill, `on_accent` label.
- Incognito is darker than `surface` and does not wash NTP tiles with `accent`.
- Do not use the original concept art’s electric cyan/teal, and do not reintroduce Folio Calm Sage in chrome.

## 4. Type

- Display / wordmark / titles: **Exo 2** (fallback Sora, Outfit)
- UI / body: **Figtree** (fallback Source Sans 3, Inter)
- Code / URLs / logs: **JetBrains Mono**

Wordmark: `CANOPY` in Exo 2 Semibold, wide tracking. Optional leaf in the O for lockups only — not in UI chrome text.

Sentence case for headlines. Product name stays Canopy (capital C).

## 5. Logo system — which file when

| Need | File | Notes |
|---|---|---|
| App icon 192–512 | `logos/canopy-app-icon.svg` or `icon-canopy-shield-dark.jpg` | Rounded square, dark field |
| Favicon / 16–64 | `logos/canopy-glyph.svg` or `glyph-favicon-dark.jpg` | Three leaves on shield. No helmet detail. |
| Marketing hero mark | `logos/mark-helmet-canopy-dark.jpg` | Helmet + living canopy. No wordmark. |
| Horizontal lockup dark | `logos/lockup-dark.jpg` or `canopy-lockup-dark.svg` | |
| Horizontal lockup light | `logos/lockup-light.jpg` | |
| Wordmark only | `logos/canopy-wordmark.svg` | |
| Narrative emblem | `logos/emblem-full-narrative.jpg` | Knight + book + locked cubes. Posters, about page, splash only. |
| Source concept (teal) | `logos/emblem-source-concept.jpg` | Reference only. Do not ship teal. |

Clear space: at least the height of one leaf around any mark.
Minimum glyph size: 16px. Minimum lockup width: 120px.

Do not:
- Recolor leaves neon, gold, or RGB
- Add slogans into the mark
- Place the full knight-writing emblem in a toolbar or notification
- Outline the mark in clay
- Stretch, rotate >5°, or add drop shadows that look “glossy 2012”
- Combine helmet mark + radiating app icon in the same lockup

## 6. Imagery

Allowed: faceted geometric armor, umbrella canopies of leaves, paper/books, quiet forests, locked isometric volumes, hairline circuit traces *subordinate* to foliage.

Not allowed: skulls, rifles, glowing anonymizing masks, onion-routing fan art, generic chrome globes, stock “hacker in hoodie.”

Photography (if any): overcast woodland, paper, stone, linen. Desaturate toward sage. No golden-hour lifestyle shots of laptops in cafes.

## 7. UI notes for agents building the browser

- Chrome is quiet. One accent (`accent`).
- Private / shielded state uses `on_surface` on `accent_container`, not a red recording dot.
- Warning / insecure: plain language, not screaming orange.
- Address bar on `surface_high`, page canvas on `surface` or `paper`.
- Tabs: hairline `outline`, active tab `accent` pip.
- Empty states may use the glyph, not the full narrative emblem.

## 8. Copy patterns

Good short lines:
- Browse under cover.
- A quiet place on the open web.
- What you read stays under the canopy.
- Shields up. Trackers out.

Avoid:
- “Military-grade encryption” as a headline
- “Web3”, “decentralized identity” unless the product actually ships that
- Fear copy (“they are watching you”)

## 9. Platforms

Ship the same brand on Android and Linux. Do not fork colors per OS. Adaptive Android icon stays the existing glyph; do not recolor launcher mipmaps for this palette cut.

## 10. Checklist before shipping a generated asset

- [ ] Only the Canopy purple / AMOLED hexes in section 3
- [ ] Correct mark for the size
- [ ] Exo 2 / Figtree (or named fallbacks)
- [ ] Canopy spelled once, no tagline baked into the logo
- [ ] Dark default looks like `surface` `#0B0B10`, not Google grey or teal
- [ ] No teal leftover from the source concept art
