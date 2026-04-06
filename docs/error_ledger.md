# Error ledger

**Application ID:** `uk.co.tiabellavideo.hub`  
**Repository:** `0027-uk.co.tiabellavideo.hub`

Chronological index of logged incidents. Full detail: `ops/incidents/INC-*.md`.

## Process (before commit when you fix an issue)

If you fix or document a **build**, **test**, **signing**, **routing**, **screenshot**, or **workflow** problem:

1. Add or update an incident file under `ops/incidents/` (use `_TEMPLATE.md`).
2. Append a row to **Incident index** below.
3. Add or update a **failure pattern** in `docs/failure_patterns.md` when the lesson is reusable.

Do **not** change the Android application ID / package name when doing this.

---

## Incident index

| ID | Date | Area | Severity | Status | Summary | Detail |
|----|------|------|----------|--------|---------|--------|
| INC-20260405-001 | 2026-04-05 | workflow | low | mitigated | Flutter/Dart not on PATH in some shells; analyze/test could not run | [ops/incidents/INC-20260405-001-flutter-sdk-path.md](../ops/incidents/INC-20260405-001-flutter-sdk-path.md) |
| INC-20260405-002 | 2026-04-05 | routing | medium | resolved | `go_router` navigation from modal used wrong `BuildContext` | [ops/incidents/INC-20260405-002-modal-router-context.md](../ops/incidents/INC-20260405-002-modal-router-context.md) |
| INC-20260405-003 | 2026-04-05 | test | low | resolved | Taps on bottom actions inside `ListView` failed without `ensureVisible` | [ops/incidents/INC-20260405-003-scrollable-cta-visibility.md](../ops/incidents/INC-20260405-003-scrollable-cta-visibility.md) |
| INC-20260405-004 | 2026-04-05 | workflow | low | resolved | PowerShell rejected `&&` when chaining `cd` and `dart`/`flutter` | [ops/incidents/INC-20260405-004-powershell-command-chaining.md](../ops/incidents/INC-20260405-004-powershell-command-chaining.md) |
| INC-20260405-005 | 2026-04-05 | routing | low | resolved | `/about` had no contract inbound; Settings → About Us added | [ops/incidents/INC-20260405-005-about-reachability.md](../ops/incidents/INC-20260405-005-about-reachability.md) |
| INC-20260405-006 | 2026-04-05 | screenshot | low | resolved | Store goldens need no network fonts + fixed 1080×1920 surface | [ops/incidents/INC-20260405-006-golden-fonts-surface.md](../ops/incidents/INC-20260405-006-golden-fonts-surface.md) |
| INC-20260405-007 | 2026-04-05 | signing | medium | open | Release build type still points at debug signing config | [ops/incidents/INC-20260405-007-release-debug-signing.md](../ops/incidents/INC-20260405-007-release-debug-signing.md) |

---

## Stats (manual)

- **Open:** 1 (signing placeholder)
- **Resolved / mitigated:** 6
