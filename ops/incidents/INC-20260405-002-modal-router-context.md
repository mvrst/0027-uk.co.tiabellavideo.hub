# INC-20260405-002 — Modal bottom sheet used wrong router context

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | routing |
| **Severity** | medium |
| **Status** | resolved |

## Summary

Portfolio filter sheet navigated with a context that did not work reliably with `go_router` after closing the modal.

## Symptoms

- Filter actions did not navigate, or navigation failed silently, when using the sheet builder’s `context`.

## Root cause

Overlay/sheet `BuildContext` is not the same as the host route context for `GoRouter.of(context).go(...)`.

## Fix / workaround

- Capture outer context before `showModalBottomSheet`: `final root = context;` then `Navigator.pop(sheetCtx); root.go(RoutePaths....);`

## Prevention

`FP-02`

## References

- `app/lib/widgets/portfolio_filter_sheet.dart`
