# INC-20260405-003 — Widget tests missed off-screen CTAs

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | test |
| **Severity** | low |
| **Status** | resolved |

## Summary

Taps on submit/send buttons at the bottom of scrollable pages failed in widget tests because targets were outside the viewport.

## Symptoms

- `flutter test` could not tap `Tk.s07Submit`, `Tk.s10Send`, settings tiles, or preview CTA without scrolling.

## Root cause

Default tester viewport does not guarantee `ListView` children are laid out in the hit-test region.

## Fix / workaround

- Call `await tester.ensureVisible(find.byKey(...))` before `tap`.

## Prevention

`FP-03`

## References

- `app/test/quote_and_contact_test.dart`
- `app/test/settings_legal_privacy_test.dart`
- `app/test/portfolio_preview_test.dart`
