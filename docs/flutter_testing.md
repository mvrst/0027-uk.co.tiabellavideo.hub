# Flutter testing — Tiabella Production Hub

Project: `uk.co.tiabellavideo.hub` (Dart package name: `hub`). Repository: `0027-uk.co.tiabellavideo.hub`.

## Commands

From the `app/` directory (after `flutter pub get`):

```bash
flutter test
```

Run a single library:

```bash
flutter test test/settings_legal_privacy_test.dart
```

Integration-style binding (still headless / VM-friendly) lives in a **separate package** under `app/integration_test/` so release Gradle builds do not register the `integration_test` Android plugin. Run:

```bash
cd integration_test
flutter pub get
flutter test hub_ci_smoke_test.dart
```

## Conventions

- **Google Fonts:** test files that pump `AppTheme.light` call `configureHubTestFonts()` in `setUpAll` so `GoogleFonts.config.allowRuntimeFetching = false` — no network font fetches in CI.
- **URL launching:** tests that trigger `url_launcher` register `bindUrlLauncherRecording` on `MethodChannel('plugins.flutter.io/url_launcher')` and clear it in `tearDown` via `unbindUrlLauncherMock()`.
- **Pumps:** use `pumpHubFrames` / `pumpAsyncGap` from `test/support/test_harness.dart` instead of unbounded `pumpAndSettle()`.
- **Router entry:** `createAppRouter(initialLocation: ...)` supports starting on any registered route for fast, deterministic flows (production still defaults to `/splash`).

## Privacy policy contract

`settings_legal_privacy_test.dart` asserts that the Settings Privacy Policy row results in a platform launch of exactly `https://tiabellavideo.co.uk/privacy-policy` (same as `kPrivacyPolicyUrl` / `docs/routes.yaml`).

## Play Store screenshots (widget goldens)

See [screenshots_workflow.md](screenshots_workflow.md) and [screenshots_manifest.md](screenshots_manifest.md). Generator: `app/test/screenshots/store_screenshot_golden_test.dart` (tags `store-screenshots`, **`store_listing`**). Release CI runs `flutter test --exclude-tags store_listing` so listing goldens are not part of AAB builds. Codemagic workflow id: **`store_screenshots`** (no `android_signing`).

## Layout

| Path | Role |
|------|------|
| `app/test/support/test_harness.dart` | Shared fonts + URL mock + pump helpers + `hubTestShell` |
| `app/test/*_test.dart` | Widget tests by flow |
| `app/test/screenshots/` | Play Store 1080×1920 golden PNG pipeline |
| `app/integration_test/` (`pubspec.yaml` + `hub_ci_smoke_test.dart`) | Minimal integration binding smoke (own `flutter pub get`; not in main app plugin list) |
