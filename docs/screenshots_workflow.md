# Play Store screenshots workflow

**Application ID:** `uk.co.tiabellavideo.hub`  
**Repository:** `0027-uk.co.tiabellavideo.hub`  

## Approach

- **Widget golden tests** (`matchesGoldenFile`) — not `flutter drive`.
- Fixed **1080×1920** logical surface, **device pixel ratio 1.0** → PNG pixel dimensions **1080×1920**.
- **Deterministic pumps** via `pumpStoreScreenshotLayout()` (bounded frames, no `pumpAndSettle`).
- **Google Fonts:** runtime fetching disabled in harness (`configureHubTestFonts()`).
- **`url_launcher`:** method-channel mock returns immediately (see `test/support/test_harness.dart`).
- **SharedPreferences:** seeded values for stable Settings toggles (see `store_screenshot_harness.dart`).

Full manifest: [screenshots_manifest.md](screenshots_manifest.md).

## Local generation

```bash
cd app
flutter pub get
flutter test test/screenshots/store_screenshot_golden_test.dart --update-goldens --tags store-screenshots
```

Outputs appear under:

`app/test/screenshots/goldens/*.png`

## Verify goldens (no file changes)

```bash
cd app
flutter test test/screenshots/store_screenshot_golden_test.dart --tags store-screenshots
```

## Codemagic: `store_screenshots`

**Workflow name (machine id):** `store_screenshots`  
**Definition:** repository root `codemagic.yaml`

### How to trigger

1. **Manual run** in Codemagic: select workflow **store_screenshots** → **Start new build** (recommended for listing refreshes).
2. **Git trigger** (optional): in the Codemagic UI, attach this workflow to a branch pattern (e.g. `store-assets/*`) or tag pattern if you want automatic runs — adjust `codemagic.yaml` `triggering` section to match your policy.

### What the workflow does

1. `flutter pub get` in `app/`
2. Runs golden generation with `--update-goldens` so CI always materializes PNGs
3. Publishes **`app/test/screenshots/goldens/**/*.png`** as downloadable artifacts for Play Console upload

### After CI

Download the artifact archive, extract PNGs, and upload to Google Play **Phone screenshots**.

## Repository automation script

`ops/run_flutter_tests.ps1` runs the main test suite only. For screenshots, use the commands above or Codemagic.
