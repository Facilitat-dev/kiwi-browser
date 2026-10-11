# Privacy hardening

Canopy is Chromium **153.0.8010.39** (`CHROMIUM_VERSION`), package `app.canopy.browser`, desktop-Android (`is_desktop_android = true`). Stock Chromium phones home. This note lists the surfaces that do, the switch that kills each one, the risk, and whether this slice turns it off by default or removes it.

Patches `0031`–`0036` are the low-risk slice. `0019`–`0030` belong to other work that is not in this tree. `0037`–`0039` stay unused in this range. Do not use `0040+` for this slice.

No full Chromium build was run. `git apply --check` was run against the 153.0.8010.39 sources for the files these patches touch. It was not run against a full `chromium/` checkout, because this workspace does not have one.

## Hard constraints

- `is_desktop_android` stays true. Afterbird patches `0001`–`0006` stay as they are.
- Extensions stay installable from the Chrome Web Store, and extension actions stay clickable. Patch `0005` (webstore desktop UA) stays. Component-updater **update URLs** stay. Chrome Web Store installs go through `ExtensionUpdater` and `clients2.google.com/service/update2/crx`, not through component-updater pings.
- uBlock Origin already ships in the APK via patch `0006`. This slice does not replace it with a Google subresource-filter list.
- No Lemur, AdMob, Umeng, Play Billing, advertising id, or remote extension kill list. The Lemur items below are behavior, not a port of Lemur's code. Do not decompile Lemur or copy its layouts, strings, or hosts. See `docs/LEMUR-AUDIT.md` on `cursor/lemur-behavior-audit-a4fd`.

## Prior art

Cited only. Nothing from these trees is vendored.

| Source | License | What we used it for |
|---|---|---|
| [ungoogled-chromium `flags.gn`](https://github.com/ungoogled-software/ungoogled-chromium/blob/master/flags.gn) | BSD-3-Clause | Which GN args they set: empty API keys, `disable_fieldtrial_testing_config`, `enable_reporting=false`, `enable_mdns=false`, `enable_service_discovery=false`, `enable_remoting=false`, `safe_browsing_mode=0`. We do **not** set `safe_browsing_mode=0` (see Safe Browsing). |
| ungoogled-chromium series (`disable-crash-reporter`, `disable-gcm`, `disable-domain-reliability`, `disable-privacy-sandbox`, inox `0015-disable-update-pings`, `0003-disable-autofill-download-manager`, `0021-disable-rlz`) | BSD-3-Clause | Names of the surfaces. Patch bodies are not copied. |
| [Cromite](https://github.com/uazo/cromite) `build/cromite.gn_args`, `docs/PRIVACY_POLICY.md`, patches `Disable-various-metrics`, `Disable-fetching-of-all-field-trials`, `Modify-default-preferences` | GPL-2.0-or-later | They force Safe Browsing and variations off with no user toggle, and they default `kSafeBrowsingEnabled` to false. Canopy keeps a settings toggle and does not copy the patches. Bromite is the predecessor of Cromite and the same license applies. |

## GN already set

`branding/args.gn`, `.build/args/release.gn`, and `.build/args/test.gn` already had, and still have:

| Arg | What it actually does on 153 |
|---|---|
| `use_official_google_api_keys = false`, empty key / client id / secret | No official Google API credentials. |
| `is_chrome_branded = false` | Crash upload URL in `components/crash/core/app/crash_reporter_client.cc` `GetUploadUrl()` is empty unless `GOOGLE_CHROME_BRANDING && OFFICIAL_BUILD`. Variations seed fetch in `IsFetchingEnabled()` (`components/variations/service/variations_service.cc`) returns false unless `--variations-server-url` is passed. |
| `disable_fieldtrial_testing_config = true` | Drops the testing field-trial config. It does **not** by itself stop a Chrome-branded Finch fetch. Non-Chrome branding already skips that fetch. |
| `enable_reporting = false` | W3C Reporting / Network Error Logging (`net/features.gni`). Not UMA and not crash upload. |
| `enable_hangout_services_extension = false` | No Hangouts extension. |
| `enable_mdns = false` | No mDNS. This also turns off the `chrome.mdns` extension API. It does not affect Chrome Web Store installs or extension action icons. |
| `enable_remoting = false`, `enable_vr = false`, `enable_arcore = false`, `enable_openxr = false`, `build_contextual_search = false` | No remoting, VR/AR, or contextual search. Left as already set. |
| `enable_bound_session_credentials = false` | No bound-session cookie refresh. Default is already false on Android. |
| `enable_request_header_integrity = false` | No request-header attestation. The branded target in `chrome/BUILD.gn` is behind `is_chrome_branded`, which is false. |
| `safe_browsing_use_unrar = false`, `enable_widevine = false`, `enable_pdf = false`, `enable_plugins = false` | No unrar, Widevine, PDF, or plugins. |
| `chrome_pgo_phase = 0` | No PGO profile download (release args). |

This slice adds two explicit args next to `enable_mdns`, in all three GN files:

| Arg | Why |
|---|---|
| `enable_service_discovery = false` | `chrome/common/features.gni` defaults it to `enable_mdns`. Setting it records the choice. |
| `enable_rlz = false` | `rlz/buildflags/buildflags.gni` already defaults this false on Android (`is_chrome_branded &&` desktop). The Google search URL template still has an `{google:RLZ}` placeholder. Canopy does not default to Google, and the RLZ library stays off. |

`safe_browsing_mode` is **not** set. See below.

## Surfaces

"Off by default" means a pref or a runtime branch. The code remains, and a setting can turn it back on where noted. "Removed" means the call path cannot send the data.

| Surface | Switch | Risk | Decision |
|---|---|---|---|
| UMA / metrics upload | `PRIVACY_METRICS_REPORTING_PERMITTED_BY_USER` already defaults false (`PrivacyPreferencesManagerImpl`). First run was opt-out: `FullscreenSigninMediator` set `mAllowMetricsAndCrashUploading = true` when no enterprise policy was present, then `acceptTermsOfService` wrote that into the pref. `FirstRunActivityBase.DEFAULT_METRICS_AND_CRASH_REPORTING` only feeds a histogram; flipping it alone does not change consent. | Users who want crash reports lose them until they opt in. Enterprise policy path is unchanged. | **Off by default.** Patch `0033` sets the mediator to false and the histogram constant to false so they match. The UMA dialog can still turn reporting on. |
| Crash upload URL | Empty unless Chrome-branded official build. `GetCollectStatsConsent()` defaults false. | None beyond the metrics row. | Already empty. Consent follows the metrics opt-in above. Not removed from the binary. |
| Variations / Finch seed | `IsFetchingEnabled()` is false when not `GOOGLE_CHROME_BRANDING`, unless `--variations-server-url` is set. `kDisableVariationsSeedFetch` is Chrome-branded only. | A command-line URL could still fetch a seed. We do not ship that switch. | **Already off** for seed fetch. Not compiled out. |
| `X-Client-Data` | `ShouldAppendVariationsHeader` (`components/variations/net/variations_http_headers.cc`) attached the header to Google / DoubleClick / YouTube hosts outside incognito even when the seed fetch was off. | None for page loads. Experiments that depended on the header cannot run. | **Removed.** Patch `0032` returns false. |
| Field-trial testing config | `disable_fieldtrial_testing_config = true` | Already set. | **Off at build time.** |
| Component-updater pings | `ConfiguratorImpl::PingUrl()` returned `UpdateUrl()` when pings were enabled. URLs are `https://update.googleapis.com/service/update2/json` and an `http://` fallback (`component_updater_url_constants.cc`). | Emptying `UpdateUrl()` or skipping `RegisterComponentsForUpdate` can break CRLSet, origin trials, and other components the Web Store install path may still touch. | **Pings removed.** Patch `0031` makes `PingUrl()` empty. `UpdateUrl()` and the registrar stay. Widevine registration is already behind `ENABLE_WIDEVINE`. |
| Chrome Web Store updates | `ExtensionUpdater`, not component-updater pings. Desktop UA is patch `0005`. | Do not block `clients2.google.com` update checks if extensions must install. | **Kept.** |
| Safe Browsing URL checks | Android default `safe_browsing_mode = 2` (`components/safe_browsing/buildflags.gni`): remote lookups. `StartUrlCheckBySafeBrowsing` JNI-calls `startUriLookupBySafeBrowsingApi` with `url.spec()` for both `LOCAL_BLOCK_LIST` and `REAL_TIME`. `StartAllowlistCheck` sends `url.spec()` to SafetyNet. `StartGetSafetyNetId` fetches a device id. Pref `kSafeBrowsingEnabled` defaulted true (Settings: Standard). Enhanced defaulted false. Extended-reporting opt-in was allowed. | Mode `0` needs ungoogled's build-fix patches and drops the feature. Mode `1` is the desktop local database (`FULL_SAFE_BROWSING`). On Android, `chrome/browser/safe_browsing/BUILD.gn` then compiles desktop extension-telemetry and download-feedback sources, and a test target depends on `//chrome/browser/ui/hats:test_support`, which the BUILD file says exists only off Android. | **Off by default, and URL upload removed.** Patch `0033` defaults `kSafeBrowsingEnabled` to false (Settings "No protection") and disallows extended-reporting opt-in. Patch `0036` answers URL checks as safe without JNI, returns false from the allowlist check, and returns an empty SafetyNet id. Standard / Enhanced remain in Settings; turning them on still does not send the URL. **Local hash-prefix lists are the later state**, not this slice. No Lemur Safe Browsing host. |
| Domain reliability | Pref `domain_reliability.allowed_by_policy` defaulted true, and the service also follows metrics consent. | Sites lose reliability beacons. | **Off by default.** Patch `0033`. Not compiled out. |
| Network time | `kNetworkTimeQueriesEnabled` defaulted true. `ShouldIssueTimeQuery` checks it. | Clock sync no longer asks Google. | **Off by default.** Patch `0033`. |
| Discover / feed | `kEnableSnippets`, `kArticlesListVisible`, and `kEnableSnippetsByDse` defaulted true. The last one is tied to a Google default search engine. | New-tab articles stay hidden until the user turns them on. | **Off by default.** Patch `0033`. |
| Omnibox search suggest | `prefs::kSearchSuggestEnabled` defaulted true in `Profile::RegisterProfilePrefs`. | Typing in the omnibox is not sent to the search provider unless the user enables suggestions. | **Off by default.** Patch `0033`. |
| Default search | `GetPrepopulatedFallbackSearch` looked up Google, then the first regional engine. Several country lists omit DuckDuckGo (CN, HK, KH, KR, LA, MN, MO, TW, UZ, VN, ZZ). ZZ is only Google, Bing, Yahoo. | Users who wanted Google must pick it. Regional unit tests that assert exact engine order will see DuckDuckGo first. | **Off the Google default.** Patch `0034` resolves DuckDuckGo from the full built-in list (`id` 92, keyword `duckduckgo.com` in `prepopulated_engines.json` at DEPS pin `b9f48dc46a8172cbdd9c3923bd5a85c04458e49f`) and inserts it at the front of every regional list. Google is added when a list does not already have it. Baidu, Sogou, Shenma, and 360 are not the default. |
| First-run search choice | `shouldShowSearchEnginePage()` was true only for `LocaleManager` promo types `SHOW_NEW` / `SHOW_EXISTING`. The fragment auto-advanced on `DONT_SHOW`. `DefaultSearchEngineDialogHelper` shuffled the list and selected nothing. | First run has one more required page, unless policy manages the default engine. The existing layout `default_search_engine_first_run_fragment` is reused. This is not a Lemur screen. | **Added.** Patch `0035`. DuckDuckGo is preselected. Brave, Ecosia, Bing, and Google follow when those keywords exist (`search.brave.com`, `ecosia.org`, `bing.com`, `google.com`). Other prepopulated engines stay on the list after those. Confirm calls `TemplateUrlService.setSearchEngine(keyword, ChoiceMadeLocation.CHOICE_SCREEN)` (`kChoiceScreen = 3` in `components/search_engines/choice_made_location.h`, generated Java `CHOICE_SCREEN`). The pick is the user pref, so later launches do not fall through to the fallback. |
| Translate | `translate.enabled` (`kOfferTranslateEnabled`) is read in `TranslatePrefs` and is **not** registered in `TranslatePrefs::RegisterProfilePrefs` on this pin. | Flipping an unregistered pref is a no-op or a DCHECK, depending on the caller. | **Not this slice.** |
| Autofill server | No single `kAutofillServerCommunication` feature. Enabled features include `kAutofillServerExperimentalSignatures`, `kAutofillServerQueryPredictionsEarly`, and `kAutofillServerUploadMoreData`. | Turning those off needs a feature-flag patch and a check that local profiles and cards still save. | **Not this slice.** Local autofill stays on. |
| GCM / FCM / Web Push | `components/gcm_driver`. Ungoogled disables it. | Disabling GCM breaks Web Push for extensions and sites. | **Kept.** |
| Sync and sign-in promos | FRE still has a sign-in page. `enable_dice_support` is desktop-only. `kSigninPromoOnAvatarPill` is behind Dice, so an Android patch there does nothing. | Removing the sign-in page is a product change, not a one-line default. | **Not this slice.** No Google account is required. No new account telemetry. |
| Hotword / Assistant | `build_contextual_search = false` is already set. No separate hotword GN arg was pinned for this slice. | A voice-search client can still exist in the tree. | **Not this slice**, beyond contextual search already being off. |
| Privacy Sandbox / ad attribution | No new GN in this slice. | Needs its own pass so it does not take down an API extensions use. | **Not this slice.** |
| Anti-fingerprinting | Ungoogled and Cromite both patch this. Cromite is GPL. | Easy to ship a detectable, half-applied spoof. | **Not this slice.** Only with a license we can ship. |
| Content blocking | Patch `0006` bundles uBlock Origin 1.62.0 and unpacks it on first launch. | Do not edit `0006` in this slice. | **Already on.** |

## What ships in `0031`–`0036`

| Patch | Change |
|---|---|
| `0031-disable-component-updater-pings` | `PingUrl()` is empty. Update checks still use `UpdateUrl()`. |
| `0032-disable-variations-client-data` | `ShouldAppendVariationsHeader` returns false. |
| `0033-privacy-pref-defaults` | Search suggest off. Feed snippets, article list, and DSE-gated snippets off. Domain reliability off. Network time queries off. Safe Browsing off. Extended-reporting opt-in disallowed. First-run metrics and crash upload start off. |
| `0034-duckduckgo-default-search` | Fallback engine is DuckDuckGo. Every regional list leads with DuckDuckGo and still contains Google. |
| `0035-first-run-search-choice` | First run shows the existing search-engine page, preselects DuckDuckGo, and stores the choice at `CHOICE_SCREEN`. Skipped only when the default engine is enterprise-managed. |
| `0036-safe-browsing-no-url-upload` | URL reputation, SafetyNet allowlist, and SafetyNet id do not leave the device. |

## Verification

- `git apply --check` succeeded for `0031`–`0036` against the 153.0.8010.39 copies of the files they edit.
- No `chromium/` tree is in this workspace, so the series was not applied to a full src checkout, and there was no `gn gen` or APK build.
- `ChoiceMadeLocation.CHOICE_SCREEN` matches `kChoiceScreen` via `GENERATED_JAVA_ENUM_PACKAGE: org.chromium.components.search_engines`. A generator rename would fail the Java compile.
- `TemplateURLPrepopulateData::duckduckgo` / `::google` are the generated symbols for the JSON keys `duckduckgo` and `google`. A generator rename would fail the C++ compile.
