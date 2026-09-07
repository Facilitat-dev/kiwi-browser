# Why Kiwi had 14 repos — and why we have one

Kiwi was a Chromium **overlay** org, not a normal app repo. They split the tree so GitHub Actions and a private build farm (`find.kiwi`) could each fetch a slice:

| Repo | Job |
|---|---|
| `src.next` | Overlay they rebased onto Chromium (the "Kiwi delta") |
| `src` | Full Android Chromium snapshot (~2.8 GB git) |
| `src.canary` | Canary assets |
| `android` | Older Android tree, later moved into `src` |
| `dependencies` | CIPD/gclient mirror so CI did not hit Google |
| `docker_image` | Build image |
| `patches` / `chromium_extension_patches` | Portable patch files for other projects |
| `content_filters` | Ad lists for Chromium's subresource_filter |
| `classic_ntp` / `logos` / `ia` | New-tab page, tile icons, instant answers |
| `extensions` / `sync` | Store HTML and a sync extension |
| Action/Flutter mirrors | Unrelated tooling they forked |

That split existed because Chromium is huge and their CI could not check out all of it from one GitHub repo. It is not a design we need.

**This repo is the working tree.** Chromium itself stays an *external checkout* under `chromium/` (gitignored, tens of GB). Patches, branding, GN args, and the pipeline live here. The `kiwi-*` GitHub forks under Facilitat-dev are lineage mirrors, not something you clone to work.
