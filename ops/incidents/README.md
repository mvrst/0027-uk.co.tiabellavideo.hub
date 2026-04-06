# Incidents

Structured records for **build**, **test**, **signing**, **routing**, **screenshot**, and **workflow** failures for `uk.co.tiabellavideo.hub`.

## New incident

1. Copy `ops/incidents/_TEMPLATE.md` → `ops/incidents/INC-YYYYMMDD-NNN-slug.md` (increment `NNN` per day).
2. Update **`docs/error_ledger.md`** (new row + summary).
3. Update **`docs/failure_patterns.md`** if a reusable rule applies (new or amended `FP-__`).
4. Commit template + ledger + patterns + incident file together.

The master index lives in **`docs/error_ledger.md`**.
