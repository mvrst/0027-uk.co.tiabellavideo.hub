# Failure patterns

Reusable prevention rules for `uk.co.tiabellavideo.hub`. When an incident teaches something general, add or extend a pattern here and reference **`FP-__`** from the incident file.

| ID | Title | Areas |
|----|--------|--------|
| FP-01 | Flutter/Dart on PATH | workflow, build, test |
| FP-02 | Router context outside overlays | routing |
| FP-03 | Scrollable CTA visibility in tests | test |
| FP-04 | Shell command chaining | workflow |
| FP-05 | Contract graph vs implementation | routing |
| FP-06 | Golden / screenshot determinism | screenshot, test |
| FP-07 | Release signing must not stay on debug | signing, build |

---

## FP-01 — Flutter/Dart on PATH

**Rule:** Before relying on local or agent output, confirm `flutter doctor` / `dart --version` succeed in **that** shell. CI images should install Flutter explicitly or use a pinned image.

**Do:** Document required SDK in `docs/flutter_testing.md`; use `ops/run_flutter_tests.ps1` from repo root on Windows.

**Don’t:** Assume `&&` works across shells (see FP-04).

---

## FP-02 — Router context outside overlays

**Rule:** When calling `context.go` / `push` after closing a `showModalBottomSheet`, capture the **caller’s** `BuildContext` (e.g. `final root = context` before `showModalBottomSheet`) and navigate with `root`, not the sheet `builder` context.

**Do:** See `app/lib/widgets/portfolio_filter_sheet.dart`.

---

## FP-03 — Scrollable CTA visibility in tests

**Rule:** For `ListView` / long scrollables, call `tester.ensureVisible(find.byKey(...))` before `tap` on bottom `ElevatedButton`s or list tiles.

**Do:** Mirror `app/test/quote_and_contact_test.dart`, `settings_legal_privacy_test.dart`, `portfolio_preview_test.dart`.

**Don’t:** Rely on unbounded `pumpAndSettle` for stability (use bounded pumps from `test/support/test_harness.dart`).

---

## FP-04 — Shell command chaining

**Rule:** On Windows PowerShell, use `;` or separate script lines instead of `&&` unless `pwsh` version and settings explicitly support it.

**Do:** Use `Set-Location ...; flutter test` in docs and ops scripts.

---

## FP-05 — Contract graph vs implementation

**Rule:** If `docs/action_map.yaml` lists a screen but no inbound action, either add a documented wiring path (e.g. Settings → About) or update the contract — don’t leave routes unreachable in tests.

**Do:** Cross-check `docs/routes.yaml` and `docs/test_matrix.yaml` when adding screens.

---

## FP-06 — Golden / screenshot determinism

**Rule:** Widget goldens for Play assets: `GoogleFonts.config.allowRuntimeFetching = false`, mock `url_launcher` channel, seed `SharedPreferences`, fixed logical size (e.g. 1080×1920 @ DPR 1.0), bounded pumps.

**Do:** `app/test/screenshots/store_screenshot_harness.dart` / `docs/screenshots_workflow.md`.

**Don’t:** Use `pumpAndSettle()` without bound for screenshot tests.

---

## FP-07 — Release signing must not stay on debug

**Rule:** `release` must use your **upload** keystore (Play App Signing), not `signingConfigs.debug`.

**Do:** Replace `signingConfig = signingConfigs.getByName("debug")` in `app/android/app/build.gradle.kts` with a `release` signing config backed by `key.properties` / CI secrets.

**Incident:** INC-20260405-007.

---

## Changelog (pattern doc)

| Date | Change |
|------|--------|
| 2026-04-05 | Initial patterns FP-01–FP-07 from backfilled incidents. |
