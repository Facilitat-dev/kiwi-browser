# Canopy — Agent Brand Kit

Use this file as the source of truth when generating UI, copy, icons, slides, store listings, or docs for **Canopy**, a privacy-centric browser for Android and Linux.

Companion files:
- `tokens/tokens.json` — machine-readable colors, type, logo roles
- `tokens/folio-calm-sage-swatches.svg` — official palette
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

## 3. Color — Folio Calm Sage

Use only these tokens. Do not invent extra greens or cyans.

| Token | Hex | Use |
|---|---|---|
| `paper` | `#F7F9F7` | Light surfaces |
| `pine` | `#181C1A` | Dark surfaces, text on light |
| `cream_text` | `#E0E3DF` | Text on dark |
| `primary` | `#496556` | Primary actions, brand |
| `sage_seed` | `#6B8E7D` | Secondary, hover, leaves |
| `sage_light` | `#98B4A4` | Highlights, selected |
| `container` | `#2F483D` | Elevated dark cards, nav |
| `clay` | `#D4B197` | Rare warm accent (human, analog) |
| `slate` | `#A6B7C6` | Cool accent, links on dark |
| `outline` | `#3F4843` | Hairlines |

Rules:
- Default product UI is **dark pine** with cream text. Light paper mode is supported.
- Primary buttons: `primary` fill, `cream_text` label.
- Clay is never a large fill. One warm note per composition max (book pages, a quote rule, an illustration highlight).
- Do not use the original concept art’s electric cyan/teal. Recolor to sage.

Contrast:
- Cream on pine: body text
- Pine on paper: body text
- Sage light on pine: secondary
- Never sage-seed text on container (too close)

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

- Chrome is quiet. One accent at a time.
- Private / shielded state uses `sage_light` on `container`, not a red recording dot.
- Warning / insecure: use `clay` at low saturation plus plain language, not screaming orange.
- Address bar on `container`, page canvas on `pine` or `paper`.
- Tabs: hairline `outline`, active tab `primary` underline or sage-light pip.
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

Ship the same brand on Android and Linux. Do not fork colors per OS. Adaptive Android icon: sage glyph on pine, no OEM-colored theming of the mark itself.

## 10. Checklist before shipping a generated asset

- [ ] Only Folio Calm Sage hexes
- [ ] Correct mark for the size
- [ ] Exo 2 / Figtree (or named fallbacks)
- [ ] Canopy spelled once, no tagline baked into the logo
- [ ] Dark default looks like pine, not generic #000 or teal
- [ ] No teal leftover from the source concept art
