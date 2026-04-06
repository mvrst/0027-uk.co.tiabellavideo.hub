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

Integration-style binding (still headless / VM-friendly):

```bash
flutter test integration_test/hub_ci_smoke_test.dart
```

## Conventions

- **Google Fonts:** test files that pump `AppTheme.light` call `configureHubTestFonts()` in `setUpAll` so `GoogleFonts.config.allowRuntimeFetching = false` — no network font fetches in CI.
- **URL launching:** tests that trigger `url_launcher` register `bindUrlLauncherRecording` on `MethodChannel('plugins.flutter.io/url_launcher')` and clear it in `tearDown` via `unbindUrlLauncherMock()`.
- **Pumps:** use `pumpHubFrames` / `pumpAsyncGap` from `test/support/test_harness.dart` instead of unbounded `pumpAndSettle()`.
- **Router entry:** `createAppRouter(initialLocation: ...)` supports starting on any registered route for fast, deterministic flows (production still defaults to `/splash`).

## Privacy policy contract

`settings_legal_privacy_test.dart` asserts that the Settings Privacy Policy row results in a platform launch of exactly `https://tiabellavideo.co.uk/privacy-policy` (same as `kPrivacyPolicyUrl` / `docs/routes.yaml`).

## Play Store screenshots (widget goldens)

See [screenshots_workflow.md](screenshots_workflow.md) and [screenshots_manifest.md](screenshots_manifest.md). Generator: `app/test/screenshots/store_screenshot_golden_test.dart` (tag `store-screenshots`). Codemagic workflow id: **`store_screenshots`**.

## Layout

| Path | Role |
|------|------|
| `app/test/support/test_harness.dart` | Shared fonts + URL mock + pump helpers + `hubTestShell` |
| `app/test/*_test.dart` | Widget tests by flow |
| `app/test/screenshots/` | Play Store 1080×1920 golden PNG pipeline |
| `app/integration_test/hub_ci_smoke_test.dart` | Minimal integration binding smoke |
