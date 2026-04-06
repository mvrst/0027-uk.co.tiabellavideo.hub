# INC-20260405-006 — Non-deterministic store screenshot goldens

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | screenshot |
| **Severity** | low |
| **Status** | resolved |

## Summary

Play Store widget goldens would hang or drift if Google Fonts fetched at runtime or if viewport size / DPR were inconsistent.

## Symptoms

- Slow or flaky `flutter test` for goldens; PNG dimensions not exactly 1080×1920; font raster differences across OS.

## Root cause

Network font loading, unbounded animation idle, and implicit default surface size.

## Fix / workaround

- `configureHubTestFonts()`; mock `url_launcher`; seed prefs; `tester.view.physicalSize` + `devicePixelRatio`; `pumpStoreScreenshotLayout` bounded pumps; `RepaintBoundary` root.

## Prevention

`FP-06`

## References

- `app/test/screenshots/store_screenshot_harness.dart`
- `docs/screenshots_workflow.md`
