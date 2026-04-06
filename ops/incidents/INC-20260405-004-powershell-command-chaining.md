# INC-20260405-004 — PowerShell `&&` parsing failure

| Field | Value |
|-------|--------|
| **Package** | `uk.co.tiabellavideo.hub` (unchanged) |
| **Date** | 2026-04-05 |
| **Area** | workflow |
| **Severity** | low |
| **Status** | resolved |

## Summary

Chaining `cd app && dart analyze` failed on Windows PowerShell 5.x with a parser error.

## Symptoms

- `ParserError` / "token `&&`" not valid in PowerShell.

## Root cause

`&&` is not universally supported in older PowerShell; bash-style chaining was copied into docs or scripts.

## Fix / workaround

- Use `Set-Location app; dart analyze` or separate lines; or run under `pwsh` 7+ if `&&` is required.

## Prevention

`FP-04`

## References

- `ops/run_flutter_tests.ps1` (uses `;` style)
