# Play Store screenshot goldens (PNG)

These PNG files are **generated** by widget golden tests — do not paint them by hand.

- **Output directory (repository):** `app/test/screenshots/goldens/`
- **Generator:** `app/test/screenshots/store_screenshot_golden_test.dart`
- **Logical size:** 1080×1920 @ 1.0 DPR (see `store_screenshot_harness.dart`)

## Regenerate locally

From `app/`:

```bash
flutter pub get
flutter test test/screenshots/store_screenshot_golden_test.dart --update-goldens --tags store-screenshots
```

## CI

The Codemagic workflow **`store_screenshots`** runs the same command and publishes `app/test/screenshots/goldens/*.png` as build artifacts (see `docs/screenshots_workflow.md`).

For pixel-stable baselines, prefer generating on **Linux** (same image family as Codemagic) before committing updated goldens.
