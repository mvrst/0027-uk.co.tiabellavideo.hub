# INC-20260405-005 — `/about` screen unreachable from documented actions

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | routing |
| **Severity** | low |
| **Status** | resolved |

## Summary

`docs/action_map.yaml` did not define an inbound navigation action to `/about` while the route existed, leaving S11 untestable from the documented graph.

## Symptoms

- No primary path to About Us without ad-hoc deep link.

## Root cause

Contract gap: route registered but no mapped CTA.

## Fix / workaround

- Added Settings → **About Us** (`Tk.s13About`) → `context.push(RoutePaths.about)` (documented as wiring beyond original action_map).

## Prevention

`FP-05`

## References

- `app/lib/pages/s13_settings_page.dart`
- `app/lib/core/test_keys.dart` (`s13About`)
- `docs/action_map.yaml`
