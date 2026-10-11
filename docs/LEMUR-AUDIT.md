# Lemur behavior audit

Behavior only. This note compares public descriptions of **Lemur Browser** (`com.lemurbrowser.exts`) with Canopy (`app.canopy.browser`, Chromium 153). It is a spec for what to build, and what to leave out, so Canopy can feel like Lemur on a phone while staying simpler and collecting less.

**Hard limit.** No Lemur APK was downloaded, decompiled, or disassembled. No Lemur code, resource strings, layouts, images, or endpoints are copied here. Claims come from the Play listing, Lemur’s site and privacy policy, public changelogs, reviews, and the Exodus Privacy report. Each claim has a URL. Where two public pages disagree, both are kept and dated.

Observed **11 October 2026**.

Slice numbers follow [UI-PORT.md](UI-PORT.md) and [UI-PORT-PLAN.md](UI-PORT-PLAN.md).

## How to read Canopy status

| Status | Meaning in this repo |
|---|---|
| **done** | Patch is in `patches/m153/` on this branch’s parent (`0001`–`0018`). |
| **planned slice** | Written in UI-PORT-PLAN. Slices 3, 5, and 6 exist on Kyle’s machine and are not pushed: `0019`–`0021` (tile NTP / no Discover) and `0023`–`0027` (AMOLED dark, darken websites, edge swipe, swipe-up tab switcher, grid default). Slice 7 (`0028`–`0030`) is planned and not in that unpushed set. |
| **missing** | No slice yet. |
| **deliberately skip** | Public Lemur behavior Canopy leaves out. |

`0022` stays dropped (do not turn off `is_desktop_android`). See UI-PORT-PLAN.

---

## 1. Feature inventory

Lemur is a closed-source Chromium browser for Android. The current Play title is **Lemur Browser: Web Extensions**, developer **Chongqing Aosiman Front-line Technology Co., Ltd.** The listing says **Contains ads** and **In-app purchases**, content rating Everyone, updated **10 October 2026**. [Play listing](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

A separate beta app, `com.lemurbrowser.exts.beta`, was last updated **5 September 2025**. [Beta listing](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)

The marketing site describes a Chromium browser with Chrome and Edge extensions, a sidebar, pinnable extensions, site-access controls, and draggable pop-ups. It also points at **Paip.AI**, a separate social app from the same founder. [lemurbrowser.com/new](https://lemurbrowser.com/new/index.html)

An older product page still claims Chrome, Edge, and Tampermonkey support, Xbox Cloud Gaming, and “privacy and security based on the Chromium kernel.” [lemurbrowser.com/app/en.html](https://lemurbrowser.com/app/en.html)

### UI chrome

Current Play about text (fetched 11 October 2026; APKMirror repeats it for 2.7.5.009):

- “Desktop UI in your pocket”: desktop tabs, a bookmarks bar, extension access. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [APKMirror 2.7.5.009](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/)
- Sidebar so an extension stays beside the page. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [site](https://lemurbrowser.com/new/index.html)
- Draggable, resizable extension pop-ups. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- Pin favorites and manage which extensions can read or change a site. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [site](https://lemurbrowser.com/new/index.html)
- One overflow is not what users see. A 1 April 2026 Play review says the split between two menus is confusing. [Play review, Craig](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

Phone chrome has been bottom-weighted for a long time, with a top-bar option added later:

- 13 July 2023, the founder’s Reddit post: menu and ribbon dropped to the bottom, pop-up height limited, a dedicated extensions button on the navigation bar, extension UI in a popup over the page, and swipe-up to show the address bar on any site. [r/browsers](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- Through late 2025, users still asked for a top address bar and said the bottom bar was forced. [Reddit, 27 Oct 2024](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) · [Reddit, 24 Dec 2025](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- 2.7.3.010 changelog (APKMirror upload 13 June 2025): phone tab switching to desktop mode, and “the input box and toolbar are displayed to the top.” [APKMirror 2.7.3.010](https://www.apkmirror.com/apk/konova-co-limited/lemur-browser-extensions/lemur-browser-extensions-2-7-3-010-release/lemur-browser-extensions-2-7-3-010-android-apk-download/)
- 2.7.5.007 changelog (APKMirror upload 9 October 2026): “Added top address bar mode and refined UI.” [APKMirror 2.7.5.007](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/)
- A February 2025 Reddit comment asks to hide the URL bar while scrolling, which implies the bar stays on screen. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- October 2025: the system navigation bar still overlaps the bottom of the browser for at least one user, despite a Play note that it was fixed. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

Large-screen behavior, from the same 2023 founder post: Samsung DeX shows a desktop layout (tabs, address bar, menus, keyboard shortcuts), and PWAs are mentioned on Chromium 110. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

The January 2024 privacy policy says Lemur offers four home-screen widgets (search, pages, web apps). [Policy, 18 Jan 2024](https://www.lemurbrowser.com/policy/privacy_policy_en.html)

APKMirror’s 2.7.5.007 page lists the declared features **Supports Cardboard** and **Supports Daydream**. [APKMirror 2.7.5.007](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/) Canopy’s GN args already turn VR/AR off. [PRIVACY.md](PRIVACY.md)

### Extensions and stores

Play and the current site:

- Install from the Chrome Web Store and Microsoft Edge Add-ons, including userscripts. Named examples: Tampermonkey, AdGuard, AdBlock, Bitwarden, global speed controllers. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [site](https://lemurbrowser.com/new/index.html)
- Local `.crx` import. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- Older store text, still printed on Aptoide and on the June 2025 APKMirror about blurb, also names Dark Reader, Grammar Checker, and “Clean Master from Google,” plus uninstall / disable. [Aptoide](https://lemur-browser.en.aptoide.com/app) · [APKMirror 2.7.3.010](https://www.apkmirror.com/apk/konova-co-limited/lemur-browser-extensions/lemur-browser-extensions-2-7-3-010-release/lemur-browser-extensions-2-7-3-010-android-apk-download/)
- Founder, 2023: Chrome and Edge store entries sit in the extensions menu; the extensions button is on the navigation bar; popups float over the current tab. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- Beta review, 2 October 2025: stable Lemur can install zip / `.crx` from a file picker; the beta build opens a camera / photo sheet and fails to take a zip. [Beta listing](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)
- Play review, 3 November 2024: ad blocking sometimes misses until refresh; uBlock Origin and a paywall extension were unreliable compared with Kiwi; the reviewer believed the engine was still Chromium 124. [Play review, Zia Ur Rehman](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- June 2024 user report: extension popups over the current tab, a desktop-style context menu with extension items, and tab-manager extensions that can see open tabs. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- The January 2024 policy says Lemur may download a list of dangerous extensions and remotely disable or remove them. The 4 October 2026 policy does not repeat that. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) · [2026 policy](https://lemurbrowser.com/new/privacy.html)

There is no first-party claim of a built-in ad blocker. Ad blocking is described as an extension. The Play listing itself says the app contains ads. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

### New-tab page

Current Play text: “highly customizable, tile-based homepage” and desktop-grade tab groups. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

Older about text, still on Aptoide (page also lists version 2.7.5.009 dated 10 October 2026) and on the 2.7.3.010 APKMirror blurb:

- Homepage icons from a built-in library, plus custom icons, managed in groups. [Aptoide](https://lemur-browser.en.aptoide.com/app)
- Wallpaper catalog (ocean, landscape, animals, anime, sport) attributed to Unsplash, plus a user-uploaded wallpaper. [Aptoide](https://lemur-browser.en.aptoide.com/app)

Founder, 2023: a simple new tab (title plus search) and an Infinity-style homepage built into the browser, not only as an extension. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

User reports, not store copy: the built-in speed dial stopped at about 9 or 10 shortcuts and then folded extras into a folder (July 2023, April 2024). A November 2024 comment asked whether the NTP syncs bookmarks to a server, and asked for icon size, folders, and wallpaper controls. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

### Gestures

Public descriptions do not match one stable gesture map. Keep them dated:

| When | What was said | Source |
|---|---|---|
| Dec 2022 | XDA recommendation lists “Full Screen Gestures” with no further definition | [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |
| Jul 2023 | Swipe up on any site shows the address bar | [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) |
| Oct 2024 | A user asks how to turn off a toolbar swipe that opens a new tab or goes home | [XDA comment](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |

No public page found in this pass says Lemur uses edge-swipe for history back and forward. That behavior is a Canopy target from Kiwi, not a cited Lemur claim. [UI-PORT.md](UI-PORT.md)

### Tab switcher

- Founder, 2023: “three optional tabbed views.” [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)
- XDA, Dec 2022: “various tab page display methods.” [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/)
- Beta What’s new, still showing on 11 October 2026: “Setting -> manger tabs” (sic). [Beta listing](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)
- 2.7.3.010: “mobile phone tag switching to desktop mode.” [APKMirror](https://www.apkmirror.com/apk/konova-co-limited/lemur-browser-extensions/lemur-browser-extensions-2-7-3-010-release/lemur-browser-extensions-2-7-3-010-android-apk-download/)
- 2.7.3.013: fix tab desktop mode on some models; remove Archive Tab. [APKMirror 2.7.3.013](https://www.apkmirror.com/apk/konova-co-limited/lemur-browser-extensions/lemur-browser-extensions-2-7-3-013-release/lemur-browser-extensions-2-7-3-013-android-apk-download/)
- Beta review, 27 September 2025: desktop tab-switch mode on beta lacks an easy normal/incognito switch and a “manage windows” action that stable Lemur has. [Beta listing](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)
- Current Play about text advertises desktop-grade tab groups. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- Users still asked for a desktop tab strip in March 2025 and July 2025. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

### Dark mode

- Current Play text: “immersive dark mode for night reading.” [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- Older about text: “Nearly perfect dark mode. Users can enjoy the ultimate darkness.” [Aptoide](https://lemur-browser.en.aptoide.com/app)
- XDA, Dec 2022, lists Dark Mode separately from Dark Reader, which that post treats as an extension. [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/)
- XDA comment (screenshots dated 28 October 2024 in the attachment names): a “darken sites” style setting exists, and turning it off still forced dark pages, including the Chrome Web Store and home-screen shortcuts. [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/)
- 2.6.1.027 What’s new (Aptoide, 27 July 2024): toggling the system theme sent Incognito back to the homepage. [Aptoide](https://lemur-browser.en.aptoide.com/app)
- March 2025 Reddit request, still outstanding in that thread: pitch-black page background for AMOLED. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

### Sync, accounts, incognito

4 October 2026 privacy policy (English section on the same page):

- History, bookmarks, downloads, cookies, saved passwords, and extension data stay on device by default.
- Incognito does not write that session into regular history. Cookies created in it are dropped when the last incognito window closes. Files already downloaded elsewhere stay.
- The user can clear history, search records, cookies, cache, and saved passwords in the app.
- Optional account: nickname, or Google sign-in (account id and basic profile). Sign-out and account deletion in the app, or by email to lemurbrowser@gmail.com.
- Sync uploads only the browser data the user chose, and only after sign-in and sync are both on. [Policy, effective 4 Oct 2026](https://lemurbrowser.com/new/privacy.html)

2.7.5.007 What’s new matches the policy: “Added Google Sign-In with support for bookmark and extension syncing.” [APKMirror 2.7.5.007](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/)

The January 2024 policy also describes a Traceless mode and a Guest mode that withhold history, cache, and existing cookies. The 2026 policy speaks only about incognito. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html)

Play review, 31 May 2025: phone incognito kept searches; tablet incognito worked. The reviewer also uses Lemur with Google passwords. [Play review, Shreshth Bhargava](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

XDA, Dec 2022, lists incognito, desktop mode, find-in-page, bookmark import/export, and Google Translate among things the poster could do. [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/)

### AI

Current Play text tells users to run AI assistants, translators, or notes as extensions in the sidebar, and says the app is “evolving to support advanced workflows and AI integrations.” It does not describe a built-in model. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

A November 2023 Reddit comment says a built-in AI chat required an account, and that danmaku (on-page comment bullets) plus a tracker of visited sites were reasons to leave. A June 2024 comment says the team later removed a forced AI chatbot. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/)

Paip.AI is described as a separate social app, not as a panel inside the browser. [site](https://lemurbrowser.com/new/index.html)

### Ads, membership, rewards, community

- Play badge: Contains ads, In-app purchases. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- 2026 policy: non-members may see a Google AdMob app-open ad at launch, requested in a separate process, without reading the page the user is on. Membership, bought through Google Play, removes that ad. Lemur stores membership status and expiry, not the full card number. Where required, Google’s User Messaging Platform asks for ad consent. [Policy, 4 Oct 2026](https://lemurbrowser.com/new/privacy.html)
- AppDashboard, a third-party scrape of the Play listing, shows in-app items from $0.59 to $89.99. Treat the range as that site’s figure. [AppDashboard](https://appdashboard.app/app/com.lemurbrowser.exts)
- 2024 policy, section XI: on startup the app reads the clipboard looking for a Lemur invitation-code pattern, for a referral-rewards program. Other clipboard contents are discarded. The 2026 policy does not repeat this. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html)
- Community: current Play text says users can post, like, comment, and share sites and extensions inside the app. The 2026 policy says those posts are stored and shown to other people. Older about text calls the feedback place “Rabbit Nest.” [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [2026 policy](https://lemurbrowser.com/new/privacy.html) · [Aptoide](https://lemur-browser.en.aptoide.com/app)

### Search defaults

Two public texts, both still online:

| Text | Engines | Default stated? | Source |
|---|---|---|---|
| Live Play about, 11 Oct 2026, and APKMirror’s 2.7.5.009 about | Google, Bing, Baidu, Yandex, DuckDuckGo, custom | No default named | [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [APKMirror](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/) |
| Older about, still on Aptoide and on APKMirror’s 2.7.3.010 page | Google, Sougou, Shenma, Being, 360haosou, Yandex, DuckDuckGo, custom | “Baidu is the default search engine” | [Aptoide](https://lemur-browser.en.aptoide.com/app) · [APKMirror 2.7.3.010](https://www.apkmirror.com/apk/konova-co-limited/lemur-browser-extensions/lemur-browser-extensions-2-7-3-010-release/lemur-browser-extensions-2-7-3-010-android-apk-download/) |

Canopy’s rule stays the one in UI-PORT: the user picks the engine, and Baidu is not the default. [UI-PORT.md](UI-PORT.md)

### Other public behavior

- QR: current Play text says local import, recognition, and generating a code for a page. The 2026 policy says the camera is used when the user starts a scan. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [2026 policy](https://lemurbrowser.com/new/privacy.html)
- Video: current Play text claims a built-in video player. Aptoide’s 2.6.1.027 notes mention “Super Video” that still works after the screen locks, and a fullscreen button bug. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [Aptoide](https://lemur-browser.en.aptoide.com/app)
- DevTools: a May 2024 Reddit comment says Lemur opened devtools in the same tab, and asks for a split view with the page. The current Play What’s new (fetched 11 October 2026) does not mention devtools. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) · [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)
- External downloader: the 2024 policy says `QUERY_ALL_PACKAGES` is used to open a third-party app, to hand a download to an external downloader, and to set the default browser. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html)
- Voice search, image search, and image recognition are permission purposes in the 2024 policy. The 2026 policy limits the microphone and location to “a page, or a feature you open.” [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) · [2026 policy](https://lemurbrowser.com/new/privacy.html)
- Xbox Cloud Gaming is a claim on the old product page only. [app/en.html](https://lemurbrowser.com/app/en.html)

### Engine version, as publicly claimed

These are claims, not measurements.

| Date | Claim | Source |
|---|---|---|
| 13 Jul 2023 | Founder: Chromium 110.x | [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) |
| 3 Nov 2024 | Play reviewer: still on 124 | [Play review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| 9 Oct 2026 | 2.7.5.007 What’s new: security patches “in Chromium v127” | [APKMirror](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/) |

Canopy’s pin is Chromium **153.0.8010.39**. [README](../README.md)

---

## 2. Trackers, SDKs, permissions, data collection

### Play data-safety form

On the stable listing, the developer declares:

- No data shared with third parties
- No data collected
- Data is encrypted in transit
- The user can request deletion

[Play data safety](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en)

The beta listing declares no sharing and no collection, and does not repeat the encryption or deletion lines. [Beta data safety](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)

That form contradicts Lemur’s own 4 October 2026 policy, which describes an account, optional sync upload, AdMob, Umeng usage statistics, and Safe Browsing URL checks. [2026 policy](https://lemurbrowser.com/new/privacy.html)

### Trackers Exodus reports

Exodus Privacy report for **2.7.5.007**, created 9 October 2026, source Google Play. Two tracker signatures:

| Tracker | Exodus category | Exodus page |
|---|---|---|
| Google AdMob | Advertising (profile also covers AdMob mediation and DoubleClick) | [Report](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/) · [AdMob profile](https://reports.exodus-privacy.eu.org/en/trackers/312/) |
| Umeng Analytics | Behavioral analytics, usage statistics, advertising platforms. Exodus notes Umeng is owned by Alibaba. | [Report](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/) · [Umeng profile](https://reports.exodus-privacy.eu.org/en/trackers/119/) |

Exodus’s own caveat: a signature is not proof the tracker runs, and an unknown tracker would be missed. [Report](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/)

The 2026 policy names the same two parties in prose: AdMob app-open ads, and Umeng “to see whether features are used,” with fields defined by Umeng’s own policy. It also says Chromium Safe Browsing may send a URL to Google. [2026 policy](https://lemurbrowser.com/new/privacy.html) · [Umeng policy, as linked by Lemur’s 2024 policy](https://www.umeng.com/page/policy)

The 2024 policy is more specific about Umeng+ and is still online. It lists device identifiers the SDK may collect (IMEI, MAC, Android ID, IDFA, OPENUDID, GUID, IMSI, OAID, location) for statistics, crash callbacks, and regional analysis, and says OAID is collected only with consent and is not tied to an identity. [2024 policy, §XII](https://www.lemurbrowser.com/policy/privacy_policy_en.html)

A December 2024 Reddit comment says Umeng is “not a data tracker.” Exodus classifies it as analytics. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) · [Umeng profile](https://reports.exodus-privacy.eu.org/en/trackers/119/)

### Permissions Exodus lists for 2.7.5.007

Thirty-seven permissions. Names below are the ones on that report, including the fully qualified ones Exodus shows in the tooltip. [Exodus 2.7.5.007](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/)

Dangerous or special, as flagged on that page:

| Permission | Exodus note |
|---|---|
| `ACCESS_COARSE_LOCATION` | approximate location, foreground |
| `ACCESS_FINE_LOCATION` | precise location, foreground |
| `CAMERA` | pictures and videos |
| `RECORD_AUDIO` | record audio |
| `READ_EXTERNAL_STORAGE` | read shared storage |
| `WRITE_EXTERNAL_STORAGE` | modify or delete shared storage |
| `SYSTEM_ALERT_WINDOW` | draw over other apps |

Advertising and push-shaped declarations on the same report:

| Permission | Why it matters |
|---|---|
| `ACCESS_ADSERVICES_AD_ID` | Android Ad Services advertising id |
| `ACCESS_ADSERVICES_ATTRIBUTION` | Ad Services attribution |
| `ACCESS_ADSERVICES_TOPICS` | Ad Services topics |
| `com.google.android.gms.permission.AD_ID` | Google advertising id |
| `com.android.vending.BILLING` | Play Billing, matches the membership / IAP story |
| `com.google.android.c2dm.permission.RECEIVE` | Cloud-messaging receive permission |
| `com.lemurbrowser.exts.permission.C2D_MESSAGE` | App-specific companion to that receive permission |

Exodus did not list Firebase Cloud Messaging as a tracker signature. The permission pair is still a declaration. Do not treat it as a detected SDK beyond the permission name. [Exodus report](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/)

Other permissions on that report:

`ACCESS_NETWORK_STATE`, `INTERNET`, `CAMERA` (already above), `DOWNLOAD_WITHOUT_NOTIFICATION`, `FOREGROUND_SERVICE`, `MANAGE_ACCOUNTS`, `MODIFY_AUDIO_SETTINGS`, `NFC`, `POST_NOTIFICATIONS`, `QUERY_ALL_PACKAGES`, `RECEIVE_BOOT_COMPLETED`, `RUN_USER_INITIATED_JOBS`, `SYSTEM_OVERLAY_WINDOW`, `USE_CREDENTIALS`, `VIBRATE`, `WAKE_LOCK`, `CREDENTIAL_MANAGER_QUERY_CANDIDATE_CREDENTIALS`, `CREDENTIAL_MANAGER_SET_ALLOWED_PROVIDERS`, `CREDENTIAL_MANAGER_SET_ORIGIN`, `com.android.launcher.permission.INSTALL_SHORTCUT`, `com.chrome.permission.DEVICE_EXTRAS`, `com.google.android.apps.now.CURRENT_ACCOUNT_ACCESS`, `com.lemurbrowser.exts.permission.READ_WRITE_BOOKMARK_FOLDERS`, `com.lemurbrowser.exts.TOS_ACKED`. [Exodus report](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/)

`QUERY_ALL_PACKAGES` is explained in the 2024 policy (open another app, external downloader, default-browser setting). Location, camera, microphone, and storage are explained in both policies as feature-gated. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) · [2026 policy](https://lemurbrowser.com/new/privacy.html)

### Permission drift

AppDashboard’s timeline for Play metadata says version 2.7.3.023, first seen 18 September 2026, dropped seven declarations: `READ_MEDIA_VISUAL_USER_SELECTED`, `READ_MEDIA_IMAGES`, `READ_MEDIA_VIDEO`, `USE_LOOPBACK_INTERFACE`, `GET_ACCOUNTS`, `READ_CONTACTS`, `OTHER_SENSORS`. The same page’s permission summary for that version still lists camera, record audio, storage, fine and coarse location, Bluetooth (including advertise, connect, scan), and notifications. Bluetooth is not in the Exodus 2.7.5.007 list of 37. Use Exodus for 2.7.5.007 and AppDashboard only as evidence that the declared set changed. [AppDashboard](https://appdashboard.app/app/com.lemurbrowser.exts) · [Exodus](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/)

### What Canopy already refuses

Release GN: empty Google API keys, no field-trial seeds, reporting off, no Hangouts / mDNS / remoting / VR / AR / contextual search, bound session credentials off, request-header integrity off, Widevine off. Ad blocking is bundled uBlock Origin, not a Google list. Safe Browsing network shutdown, domain substitution, and anti-fingerprinting are still backlog, and Cromite’s GPL patches are not imported wholesale. [PRIVACY.md](PRIVACY.md) · [V1.md](V1.md)

---

## 3. Gap table

“Planned slice (local)” means the patch is on Kyle’s machine and not in this tree. See the status key at the top.

| Lemur behavior (public) | Canopy | Notes |
|---|---|---|
| Bottom address bar on the phone | **done** — slice 2, `0014` `0015` `0016` | Default bottom on phone, top/bottom setting kept, no auto-hide, menu and suggestions grow upward. Tablet stays top. [UI-PORT-PLAN](UI-PORT-PLAN.md) |
| Top address bar as an option | **done** — same slice | Lemur’s phone default was bottom for years; 2.7.5.007 adds a top mode. Canopy already keeps the toggle. [APKMirror 2.7.5.007](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/) |
| Toolbar stays visible while scrolling | **done** — `0015` | A Lemur user asked for hide-on-scroll in Feb 2025. Canopy stays always-on. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) |
| Purple accent, dark surfaces | **done** — slice 1, `0012` `0013` | Canopy purple `#8000FF`, not a Lemur color. [UI-PORT](UI-PORT.md) |
| Chrome Web Store install, MV2, uBlock bundled | **done** — `0001`–`0006` | Lemur sells extension install as the product. Canopy already has the Afterbird stack. [FEATURES](FEATURES.md) |
| Extensions row and action icons on the phone toolbar | **done** — slice 4, `0017` `0018` | One menu row, not Lemur’s split menus. [UI-PORT](UI-PORT.md) |
| Two overflow menus | **deliberately skip** | Play review, 1 Apr 2026, calls the split confusing. Canopy uses one menu. [Play review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Extension sidebar | **missing** | Marketed on the current site. Adds chrome. Leave it out of slices 1–7. [site](https://lemurbrowser.com/new/index.html) |
| Draggable, resizable extension pop-ups | **missing** | Current Play claim. Power-user chrome, not the simple phone bar. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Pin extensions and per-site access | **missing** as its own slice | Stock extension details may already expose this under `is_desktop_android`. No Canopy patch aims at it. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Edge Add-ons store | **missing** | UI-PORT defers it. CWS stays the store. [UI-PORT](UI-PORT.md) |
| Install a local `.crx` / zip from a file picker | **missing** as a picker | `0004` allows unpacked load without dev mode. Stable Lemur’s picker is a file chooser; beta’s is a camera sheet. [Beta review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en) |
| Remote list that disables extensions | **deliberately skip** | 2024 policy only. A silent kill list is a phone-home. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) |
| Tile NTP, groups, add/remove/reorder, no Discover | **planned slice (local)** — slice 3, `0019`–`0021` | User’s unpushed note: tile NTP / no Discover. Plan also includes an incognito empty NTP in this slice. [UI-PORT-PLAN](UI-PORT-PLAN.md) |
| Unsplash wallpaper CDN and built-in art pack | **deliberately skip** | Older about text. Canopy wallpapers, if any, are local. [Aptoide](https://lemur-browser.en.aptoide.com/app) · [UI-PORT](UI-PORT.md) |
| User-chosen local wallpaper | **missing** | Optional after slice 3. [UI-PORT](UI-PORT.md) |
| Baidu (or Sogou / Shenma / 360) as the default search | **deliberately skip** | Older listing states Baidu as default. Current Play listing names no default. Canopy asks the user. [Aptoide](https://lemur-browser.en.aptoide.com/app) · [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| First-run search choice | **missing** | Not one of slices 1–7. |
| AMOLED dark chrome and “darken websites” | **planned slice (local)** — slice 5, inside `0023`–`0027` | Plan patches `0023` `0024`. Lemur users in 2025 still asked for pitch black, and a 2024 report says forced site-dark ignored the off switch. Canopy’s control has to actually turn off. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) · [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |
| Edge-swipe history, swipe-up opens the tab switcher, grid default | **planned slice (local)** — slice 6, inside `0023`–`0027` | Plan patches `0025` `0026` `0027`. This is the Kiwi gesture set in UI-PORT. Lemur’s public gestures are swipe-up for the address bar (2023) and a toolbar swipe that opens a tab or goes home (2024 complaint). Do not retarget slice 6 to those. [UI-PORT](UI-PORT.md) · [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) · [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |
| List and grid tab switcher | **planned slice (local)** — slice 6 | Lemur also advertises a third view and desktop tab groups. Phone grid/list is the Canopy cut. [UI-PORT-PLAN](UI-PORT-PLAN.md) |
| Desktop tab strip and bookmarks bar on the phone | **deliberately skip** | Current Play headline feature. UI-PORT: phone chrome does not show a desktop tab strip. `is_desktop_android` stays on for extensions. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [UI-PORT-PLAN](UI-PORT-PLAN.md) |
| Tab groups / “manage windows” | **missing** | Beta review says stable has manage windows in the desktop switcher. Out of the phone cut. [Beta review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en) |
| Strip Google promo, What’s new, Edge migration, Kiwi hosts | **planned slice** — slice 7, `0028`–`0030` | Not in the unpushed 3/5/6 set. [UI-PORT-PLAN](UI-PORT-PLAN.md) |
| Desktop site toggle | **missing** as a labeled row | UI-PORT look target. Stock Chromium has the action. Not a numbered slice. [UI-PORT](UI-PORT.md) · [XDA lists desktop mode](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |
| DevTools on device | **missing** as a Canopy patch | FEATURES.md must-keep. A May 2024 user said Lemur opened devtools in the same tab. Desktop-android may already expose Chromium’s tools. [FEATURES](FEATURES.md) · [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) |
| Bookmark import/export | **missing** | FEATURES.md must-keep. XDA lists it for Lemur. [FEATURES](FEATURES.md) · [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) |
| External download manager | **missing** | FEATURES.md must-keep. Lemur’s 2024 policy describes handing a download to another app. [FEATURES](FEATURES.md) · [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) |
| Incognito that does not keep history | **planned slice (local)** for the empty NTP only | Slice 3’s plan includes the empty incognito NTP. A May 2025 Play review says Lemur’s phone incognito stored searches. Canopy keeps Chromium’s real incognito. [Play review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Guest mode | **missing** | Named in the 2024 policy, absent from the 2026 policy. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) |
| Google sign-in, Lemur account, bookmark/extension sync | **deliberately skip** | 2026 policy and the 2.7.5.007 notes. Canopy has no sync-cookie refresh and no Google account. [2026 policy](https://lemurbrowser.com/new/privacy.html) · [PRIVACY](PRIVACY.md) |
| AdMob app-open ad, Play Billing membership to remove it | **deliberately skip** | [2026 policy](https://lemurbrowser.com/new/privacy.html) · [Play “Contains ads”](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Umeng analytics | **deliberately skip** | Exodus signature plus both privacy policies. [Exodus](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/) |
| Clipboard read for invitation codes | **deliberately skip** | 2024 policy only. [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) |
| In-app community, Rabbit Nest, Paip.AI | **deliberately skip** | [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [site](https://lemurbrowser.com/new/index.html) |
| Built-in AI chat | **deliberately skip** | Users described one, then its removal. Current copy points at extension sidebars. [Reddit](https://www.reddit.com/r/browsers/comments/14yga0f/i_made_a_mobile_browser_that_supports_the_chrome/) |
| QR scanner | **missing** | Camera permission for a feature the simple browser does not need. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) |
| Super Video / lock-screen playback | **missing** | [Aptoide 2.6.1.027](https://lemur-browser.en.aptoide.com/app) |
| Four home-screen widgets | **deliberately skip** | [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html) |
| Safe Browsing sending URLs to Google | **missing** | Lemur’s 2026 policy allows it. Canopy’s PRIVACY.md already lists “disable Safe Browsing network” as not done. [2026 policy](https://lemurbrowser.com/new/privacy.html) · [PRIVACY](PRIVACY.md) |
| Cardboard / Daydream feature flags | **deliberately skip** | Declared on the 2.7.5.007 APKMirror page. Canopy GN already disables VR/AR. [APKMirror](https://www.apkmirror.com/apk/chongqing-aosiman-front-line-technology-co-ltd/lemur-browser-extensions/lemur-browser-web-extensions-2-7-5-007-release/lemur-browser-web-extensions-2-7-5-007-android-apk-download/) · [PRIVACY](PRIVACY.md) |
| Xbox Cloud Gaming promo | **deliberately skip** | Old product page only. [app/en.html](https://lemurbrowser.com/app/en.html) |

---

## 4. Recommended new slices, ranked

Slices 1–7 stay as they are. New work starts at `0031` so it does not collide with local `0019`–`0021` and `0023`–`0030`.

1. **No Lemur network surface, and Safe Browsing stays local.** Do not add AdMob, Umeng, Play Billing, an advertising id, cloud-messaging permissions, a clipboard invitation parser, a Google account, or a remote extension kill list. Land the PRIVACY.md item Lemur’s own policy makes urgent: Safe Browsing must not send page URLs to Google. Anti-fingerprinting stays on that same track, and only with a license Canopy can ship. This is the “fewer ads, less tracking” cut. [2026 policy](https://lemurbrowser.com/new/privacy.html) · [Exodus](https://reports.exodus-privacy.eu.org/en/reports/com.lemurbrowser.exts/latest/) · [PRIVACY](PRIVACY.md)

2. **Search is a first-run choice.** Remember it. Ship no Baidu, Sogou, Shenma, or 360 default. The live Play listing no longer names a default; the older blurb did. Canopy’s UI-PORT rule already forbids a Baidu default and still needs a patch. [Play](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts&hl=en) · [Aptoide](https://lemur-browser.en.aptoide.com/app)

3. **Bookmark file import/export, and hand-off to an external download app.** Both are on the FEATURES.md must-keep list. Lemur’s public pages describe both, without requiring their account. [FEATURES](FEATURES.md) · [XDA](https://xdaforums.com/t/app-lemur-browser-v2-2-0-001-an-android-browser-supports-extensions-dark-mode-google-translate-desktop-mode.4527419/) · [2024 policy](https://www.lemurbrowser.com/policy/privacy_policy_en.html)

4. **Install an extension from a document the user picked.** `0004` is unpacked-without-dev-mode. The missing piece is a document picker for `.crx` or `.zip`. The beta review is the spec for the failure to avoid: a camera or photo sheet that cannot take a zip. [Beta review](https://play.google.com/store/apps/details?id=com.lemurbrowser.exts.beta&hl=en)

5. **Local NTP wallpaper, after slice 3.** One image the user chose. No Unsplash host. [UI-PORT](UI-PORT.md) · [Aptoide](https://lemur-browser.en.aptoide.com/app)

6. **Desktop-site row in the single overflow.** UI-PORT already wants the toggle. It is stock Chromium, made obvious. [UI-PORT](UI-PORT.md)

7. **Edge Add-ons, only if CWS is not enough.** UI-PORT already says later. A second store is another company’s endpoint. Rank it last. [UI-PORT](UI-PORT.md)

Leave these unscheduled: extension sidebar, resizable pop-ups, phone desktop tab strip, bookmarks bar, tab groups beyond list/grid, community, Paip.AI, membership, a first-party chatbot, Super Video, widgets, QR scan, voice or image search, and DeX-specific UI. They are either tracking surface, extra chrome, or both.

Do not retarget slice 6. Lemur’s published gestures are not edge-swipe history plus swipe-up-for-switcher.

---

## 5. Clean-room approach

Anything still worth having is specified from the outside and written against Chromium 153.

- This file and [UI-PORT.md](UI-PORT.md) are the behavior spec. Hooks already named in [UI-PORT-PLAN.md](UI-PORT-PLAN.md) (`ToolbarPositionController`, NTP feed flags, `WebContentsDarkModeController`, `gesturenav`, the app menu) are the implementation surface.
- Do not download, decompile, or disassemble the Lemur APK. Do not copy its layouts, strings, icons, wallpapers, hosts, or invitation-code format.
- Kiwi and Relixor in `vendor/` are older behavior references (Chromium 105 and earlier). `vendor/kiwi-classic-ntp/` is CC BY-NC-SA. Reimplement a tile page. Do not vendor that HTML. [UI-PORT](UI-PORT.md)
- When a review is the only source for a gesture, write the user-visible outcome in Canopy’s words and implement it with 153’s APIs. Slice 6 stays the Kiwi set already chosen.
- When two public pages disagree, follow the newer first-party page and leave the older sentence in the audit as history. The search-default and clipboard cases above are the pattern.
- The 4 October 2026 policy says **LemurX** is a separately published open-source browser, and that this policy applies to it only if it connects to Lemur’s account service. [2026 policy](https://lemurbrowser.com/new/privacy.html) This pass found no public LemurX repository. Do not go looking for it inside an APK. If a tree shows up later, read the license before any patch is ported.
- Matching Lemur means the phone UX Canopy already chose: bottom bar, tile homepage, one menu, dark chrome, extensions that can be installed and clicked. It does not mean matching Lemur’s ads, analytics, account, or sync.
