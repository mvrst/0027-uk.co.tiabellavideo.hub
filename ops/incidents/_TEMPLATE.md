<!--
  Copy to: ops/incidents/INC-YYYYMMDD-NNN-short-slug.md
  Fill all fields before committing alongside ledger + failure_patterns updates.
-->
# INC-YYYYMMDD-NNN — <short title>

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | YYYY-MM-DD |
| **Area** | `build` \| `test` \| `signing` \| `routing` \| `screenshot` \| `workflow` \| `other` |
| **Severity** | `low` \| `medium` \| `high` |
| **Status** | `open` \| `mitigated` \| `resolved` |

## Summary

One sentence: what broke and where.

## Symptoms

- Bullet points: commands, errors, UI behaviour.

## Root cause

Why it happened (tooling, wrong context, missing route, etc.).

## Fix / workaround

- What changed (paths, commits optional).
- If not fixed: explicit workaround.

## Prevention

Link pattern id(s): `FP-__` from `docs/failure_patterns.md`.

## References

- Files / docs / URLs (optional).
